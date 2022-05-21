class FBTools {
	conv = {
		query: (obj) => {
			if ("URLSearchParams" in window) {
				return (new URLSearchParams(obj)).toString();
			} else {
				return Object.keys(obj).map((key) => `${key}=${obj[key]}`).join("&");
			}
		}
	}
	query = {
		graphql: async (bdy) => {
			return fetch("https://www.facebook.com/api/graphql/",{
				method: "POST",
				credentials: "include",
				headers: {
					"Content-Type": "application/x-www-form-urlencoded",
				},
				body: `fb_dtsg=${await this.get.local().dtsg}&fb_api_caller_class=RelayModern&${(typeof(bdy) === "string") ? bdy : this.conv.query(bdy)}`,
			}).then((res) => res.text())
		},
		misc: async ({url, bdy}) => {
			let isFormData = bdy instanceof FormData;
			return fetch(url, {
				method: "POST",
				credentials: "include",
				...((!isFormData) ? ({
					headers: {
						"Content-Type": "application/x-www-form-urlencoded",
					}
				}) : ""),
				body: (isFormData) ? bdy : `fb_dtsg=${await this.get.local().dtsg}&${(typeof(bdy) === "string") ? bdy : this.conv.query(bdy)}`,
			}).then(async (res) => {
				let body = await res.text();
				if (body.length) {
					return body;
				} else {
					return /^2/g.test(String(res.status));
				}
			});
		},
	}
	get = {
		local: () => ({
			me: require("CurrentUserInitialData").USER_ID || document.cookie.match(/(?<=c_user=)\d+/g).pop(),
			dtsg: require("DTSGInitialData").token || document.querySelector('[name="fb_dtsg"]').value,
			dtsg_ag: require("DTSG_ASYNC").getToken(),
		}),
		ids: (url) => fetch(url).then((res) => res.text()).then((res) => ({
			postId: res.match(/(?<=story_token":")\d+(?=")/g),
			userId: res.match(/(?<=userid":")\d+/gi), // this can be pageid / userid
			groupId: res.match(/(?<=groupid":")\d+(?=")/gi),
		})),
		stickers: {
			allPacks: () => this.query.graphql({
				fb_api_req_friendly_name: "StickersStoreDialogStoreQuery",
				doc_id: 2424375857610449,
				server_timestamp: true,
				variables: JSON.stringify({
					"count": 500,
					"size":40
				}),
			}).then((res) => JSON.parse(res)).then((res) => res.data.viewer.sticker_store.available_packs),
			packInfo: (packId) => this.query.graphql({
				fb_api_req_friendly_name: "StickersStoreDialogPackDetailQuery",
				doc_id: 2696647197015163,
				server_timestamp: true,
				variables: JSON.stringify({
					"packID": packId + "",
					"profileSize": 88,
					"previewWidth": 608
				}),
			}).then((res) => JSON.parse(res)).then((res) => res.data.node),
			stickers: (packId) => this.query.graphql({
				fb_api_req_friendly_name: "StickersFlyoutPackQuery",
				doc_id: 3829078343831521,
				server_timestamp: true,
				variables: JSON.stringify({
					"stickerWidth": 512,
					"stickerHeight": 512,
					"packID": packId + "",
					"feedbackID": "",
					"hasNoFeedbackID": true,
					"numMRUStickers":40
				}),
			}).then((res) => JSON.parse(res)).then((res) => res.data.node),
		}
	}

	constructor() {}

	comments = {
		add: (obj) => {
			// Object Supported: {sticker: 123, post: 123, cmt: "your cmt", reply: 123, url: "https://www.youtube.com/"}
			return this.query.misc({
				url: "https://www.facebook.com/ufi/add/comment/",
				bdy: {
					client_id: "1489983090155:3363757627",
					session_id: "84d81e4",
					source: 2,
	
					...(obj.sticker) ? ({attached_sticker_fbid: obj.sticker}) : "",
					...(obj.post) ? ({ft_ent_identifier: obj.post}) : "",
					...(obj.cmt) ? ({comment_text: obj.cmt}) : "",
					...(obj.reply) ? ({
						reply_fbid: obj.reply,
						parent_comment_id: `${obj.post}_${obj.reply}`
					}) : "",
					...(obj.url) ? ({attached_share_url: obj.url}) : "",
				}
			});
		},
		del: (postId, cmtId) => this.query.misc({
			url: "https://www.facebook.com/ufi/delete/comment/",
			bdy: {
				client_id: "1489983090155:3363757627",
				comment_id: `${postId}_${cmtId}`,
				comment_legacyid: cmtId,
				ft_ent_identifier: postId,
				source: 2
			}
		}),
	}

	conversation = {
		setEmoji: (threadId, icon) => this.query.misc({
			url: "https://www.facebook.com/messaging/save_thread_emoji/?source=thread_settings",
			bdy: {
				thread_or_other_fbid: threadId,
				emoji_choice: JSON.parse(`"${icon}"`),
			}
		}),
		setNickname: (userId, nName, threadId = userId) => this.query.misc({
			url: "https://www.facebook.com/messaging/save_thread_nickname/?source=thread_settings",
			bdy: {
				nickname: nName,
				participant_id: userId,
				thread_or_other_fbid: threadId
			}
		}),
		send: (obj) => {
			/* Object Supported: {
					audio: 123,
					emoji: "😂_1" || "\uD83D\uDE02_3", // syntax: emoji(?_size) || size = [1,2,3]
					image: 123, // or image: [1,2,3]
					msg: "your msg {m}",
					sticker: 123,
					thread: 123,
					user: 123,
					video: 123,
					mention: {
						id: 123, // could be user id or thread id (mention everyone)
						t: "mention text" // replace "{m}" in obj.msg
					}
				}
			*/
			let mId = Math.floor(Math.random() * 999999999);

			if (obj.hasOwnProperty("emoji") && /_/g.test(obj.emoji)) {
				let splitted = obj.emoji.split("_"),
					hashTable = {
						1: "small",
						2: "medium",
						3: "large",
					};
				obj.emoji = splitted[0];
				obj.es = hashTable[splitted[1]];
			}
			if (obj.mention && obj.mention.id && obj.mention.t) {
				obj.mention.id = (obj.mention.id !== 0) ? obj.mention.id : (obj.thread || obj.user);
				obj.msg = obj.msg.replace(/\{m\}/g, obj.mention.t);
			}

			return this.query.misc({
				url: "https://www.facebook.com/messaging/send/",
				bdy: {
					action_type: "ma-type:user-generated-message",
					client: "mercury",
					ephemeral_ttl_mode: 0,
					has_attachment: false,
					message_id: mId,
					offline_threading_id: mId,
					source: "source:titan:web",
					timestamp: Date.now(),

					...(obj.audio) ? ({"audio_ids[0]": obj.audio}) : "",
					...(obj.emoji) ? ({body: JSON.parse(`"${obj.emoji}"`)}) : "",
					...(obj.es) ? ({"tags[0]": `hot_emoji_size:${obj.es}`}) : "",
					// ...(obj.file) ? ({
					// 	has_attachment: true,
					// 	"file_ids[0]": obj.file
					// }) : "",
					...(obj.image) ? ({
						has_attachment: true,
						...(Array.isArray(obj.image) ? obj.image : [obj.image]).reduce((current, item, index) => ({...current, [`image_ids[${index}]`]: item}), {})
					}) : "",
					...(obj.msg) ? ({body: obj.msg}) : "",
					...(obj.sticker) ? ({
						has_attachment: true,
						sticker_id: obj.sticker
					}) : "",
					...(obj.thread) ? ({thread_fbid: obj.thread}) : "",
					...(obj.user) ? ({other_user_fbid: obj.user}) : "",
					...(obj.video) ? ({"video_ids[0]": obj.video}) : "",
					...(obj.mention) ? ({
						"profile_xmd[0][id]": obj.mention.id,
						"profile_xmd[0][offset]": obj.msg.indexOf(obj.mention.t),
						"profile_xmd[0][length]": obj.mention.t.length,
						"profile_xmd[0][type]": "p",
					}) : "",
				}
			});
		},
		kick: (threadId, userId) => this.query.misc({ url: `https://www.facebook.com/chat/remove_participants/?uid=${userId}&tid=${threadId}` }),
		del: (threadId) => this.query.misc({
			url: "https://www.facebook.com/ajax/mercury/delete_thread.php",
			bdy: {
				"ids[0]": threadId,
			}
		}),
		typing: (threadId, typ = true) => this.query.misc({
			// typ = 0 || 1
			url: "https://www.facebook.com/ajax/messaging/typ.php",
			bdy: {
				source: "mercury-chat",
				thread: threadId,
				to: threadId,
				typ: +typ
			}
		}),
	}

	group = {
		create: (groupName, privacy = "open", discov = "anyone", userIds = "") => this.query.misc({
			// memIds: Array of user you want them to be group member
			url: "https://www.facebook.com/ajax/groups/create_post/",
			bdy: {
				ref: "discover_groups",
				"purposes[0]": "",
				name: groupName,
				privacy: privacy, // "secret" || "open"
				discoverability: discov, // "members_only" || "anyone"
				...(Array.isArray(userIds) ? userIds : [userIds]).reduce((current, item, index) => ({...current, [`members[${index}`]: item}), {})
			}
		}),
		members: {
			add: (groupId, userId) => this.query.misc({
				url: "https://www.facebook.com/ajax/groups/members/add_post/",
				bdy: {
					"members[0]": userId,
					group_id: groupId,
					message_id: "groupsAddMemberCompletionMessage",
					source: "suggested_members_new"
				}
			}),
			approveJoin: async (groupId, userId) => {
				let local = await this.get.local();
				return this.query.graphql({
					av: local.me,
					fb_api_req_friendly_name: "GroupApprovePendingMemberMutation",
					variables: JSON.stringify({
						"input":{
							"client_mutation_id": "1",
							"actor_id": local.me + "",
							"group_id": groupId + "",
							"user_id": userId + "",
							"source": "requests_queue",
							"name_search_string": null,
							"pending_member_filters": {
								"filters":[]
							}
						}
					}),
					doc_id: 1619292161474296
				});
			},
			inviteRole: (groupId, userId, role) => this.query.misc({
				// role = "invite_admin" || "remove_admin" || "invite_moderator" || "remove_moderator"
				url: `https://www.facebook.com/ajax/groups/admin_post/?${this.conv.query({
					group_id: groupId,
					user_id: userId,
					source: "profile_browser",
					operation: `confirm_${role}`
				})}`,
				bdy: {
					[role]: 1
				}
			}),
			remove: (groupId, userId, ban = false) => this.query.misc({
				url: `https://www.facebook.com/ajax/groups/remove_member/?${this.conv.query({
					group_id: groupId,
					is_undo: 0,
					member_id: userId,
					source: "profile_browser"
				})}`,
				bdy: {
					block_user: +ban,
					confirmed: true
				}
			}),
			list: (groupId, type = "all", cursor = null, isVisitor = false) => {
				let refTable = {
					all: null,
					pages: "PAGES",
					invited: "INVITED",
					reqApproval: "NEEDS_POST_APPROVAL",
					preapproved: "PREAPPROVED",
					blocked: "BLOCKED",
					suspended: "MUTED",
					unavailable: "UNAVAILABLE",
				}, vr = { // standard "get all members"
					count: 500,
					cursor,
					groupID: groupId,
					scale: 1,
					search: null,
					statusStaticFilter: refTable[type],
					id: groupId,
				}
				return this.query.graphql({
					fb_api_req_friendly_name: `GroupsCometPeople${ (isVisitor) ? "Visitors" : "Members" }PaginatedListPaginationQuery`,
					doc_id: (isVisitor) ? "7303840679690475" : "4935680523184963",
					variables: JSON.stringify(vr),
				}).then((res) => {
					let jso = JSON.parse(res).data.node[(isVisitor) ? "forum_participant_profiles" : "forum_member_profiles"],
						result = {
							page_info: jso.page_info,
							items: [],
						};
					for (let item of jso.edges) {
						let mem = {
							id: item.node.id,
							name: item.node.name,
							url: item.node.profile_url,
						};
						if (item?.membership?.meta_lines) {
							for (let meta of item.membership.meta_lines.nodes) {
								if (meta.__typename === "GroupsProfileJoinedTimeMetaline") mem.joined = meta.text.text;
							}
						}
						result.items.push(mem);
					}
					return result;
				})
			},
			mute: (groupId, userId) => this.query.misc({
				url: "https://www.facebook.com/groups/mutemember/",
				bdy: {
					group_id: groupId,
					mute_duration: "seven_days", // "half_day" || "one_day" || "three_days" || "seven_days"
					should_reload: false,
					source: "profile_browser",
					user_id: userId
				}
			}),
			preapprove: (groupId, userId, approve = 0) => this.query.misc({
				url: `https://www.facebook.com/ajax/groups/?${(approve) ? "" : "un"}trust_member/${this.conv.query({
					group_id: groupId,
					member_id: userId,
					should_reload: 1,
					source: "member_list",
				})}`,
				bdy: {
					group_id: groupId,
					member_id: userId,
					should_reload: 1,
					source: "member_list",
					"nctr[_mod]": "pagelet_group_members",
					confirmed: 1
				}
			}),
			unban: (groupId, userId) => this.query.misc({
				url: `https://www.facebook.com/ajax/groups/admin_post/?${this.conv.query({
					group_id: groupId,
					operation: "confirm_remove_block",
					source: "profilebrowser_blocked",
					user_id: userId
				})}`,
				bdy: {
					remove_block: 1
				}
			})
		},
		leave: (groupId, reAdd = false) => this.query.misc({
			// reAdd = Boolean, Which accept anyone invite you to join group again, default: false = they still can add you to group
			url: `https://www.facebook.com/ajax/groups/membership/leave/?group_id=${groupId}`,
			bdy: {
				confirmed: 1,
				prevent_readd: (reAdd) ? "on" : ""
			}
		}),
		notification: (groupId, level = 6) => this.query.misc({
			// Subscription Level: 6 - Highlight | 3 - All | 2 - Friends | 1 - Off
			url: `https://www.facebook.com/groups/notification/settings/edit/?group_id=${groupId}&subscription_level=${level}`,
		}),
		post: {
			approve: (groupId, postId) => this.query.misc({
				url: "https://www.facebook.com/ajax/groups/mall/approve/",
				bdy: {
					group_id: groupId,
					message_ids: postId,
					"nctr[_mod]": "pagelet_pending_queue"
				}
			}),
			delete: (groupId, postId) => this.query.misc({
				url: "https://www.facebook.com/ajax/groups/mall/delete/",
				bdy: {
					confirmed: 1,
					group_id: groupId,
					post_id: postId
				}
			}),
			disableComments: (postId, isDisabled = 0) => this.query.misc({
				// isDissabled || 0 -> enable | 1 -> disable
				url: "https://www.facebook.com/feed/ufi/disable_comments/",
				bdy: {
					ft_ent_identifier: postId,
					disable_comments: isDisabled
				}
			}),
			get: (groupId, cursor = null, sorting = null) => {
				// !! SLOW AF
				let vr = {
					UFI2CommentsProvider_commentsKey: "CometGroupDiscussionRootSuccessQuery",
					count: 3, // fixed, can't change
					cursor: cursor,
					displayCommentsContextEnableComment: null,
					displayCommentsContextIsAdPreview: null,
					displayCommentsContextIsAggregatedShare: null,
					displayCommentsContextIsStorySet: null,
					displayCommentsFeedbackContext: null,
					feedLocation: "GROUP",
					feedType: "DISCUSSION",
					feedbackSource: 0,
					focusCommentID: null,
					privacySelectorRenderLocation: "COMET_STREAM",
					renderLocation: "group",
					scale: 1,
					sortingSetting: sorting, // null or "CHRONOLOGICAL"
					stream_initial_count: 1,
					useDefaultActor: false,
					id: groupId,
				};
				return this.query.graphql({
					fb_api_req_friendly_name: "GroupsCometFeedRegularStoriesPaginationQuery",
					doc_id: 4902130203240933,
					variables: JSON.stringify(vr),
				}).then((res) => {
					let splitted = res.split("\n");
					let result = {
						cursor: JSON.parse(splitted[0]).data.node.group_feed.edges[0].cursor,
						items: [],
					}
					for (let item of splitted) {
						if (item.includes("GroupsCometFeedRegularStories_paginationGroup$stream$GroupsCometFeedRegularStories_group_group_feed")) {
							result.items.push({
								postedBy: item.match(/(?<=owning_profile_id":")\d+/gi)[0],
								postId: item.match(/(?<=post_id":")\d+/gi)[0],
								createdAt: item.match(/(?<=creation_time":)\d+/gi)[0],
							});
						}
					}
					return result;
				});
			},
			getPostsBy: (groupId, userId, cursor = null) => {
				let vr = {
					UFI2CommentsProvider_commentsKey: null,
					displayCommentsContextEnableComment: null,
					displayCommentsContextIsAdPreview: null,
					displayCommentsContextIsAggregatedShare: null,
					displayCommentsContextIsStorySet: null,
					displayCommentsFeedbackContext: null,
					feedLocation: "GROUP_MEMBER_BIO_FEED",
					feedbackSource: null,
					...(cursor) ? ({feedCursor: cursor}) : "",
					focusCommentID: null,
					memberID: userId,
					postsToLoad: 100,
					privacySelectorRenderLocation: "COMET_STREAM",
					renderLocation: "group_bio",
					scale: 1,
					useDefaultActor: true,
					id: groupId,
				};
				return this.query.graphql({
					fb_api_req_friendly_name: "ProfileCometContextualProfileGroupPostsFeedPaginationQuery",
					doc_id: 4326775947440153,
					server_timestamp: true,
					variables: JSON.stringify(vr),
				}).then((res) => JSON.parse(res.split("\n")[0]).data.node.group_member_feed)
					.then((res) => ({
						page_info: res.page_info,
						edges: res.edges.reduce((ar, item) => ((item.node.comet_sections) ? ar.push({
							cursor: item.cursor,
							postId: item.node.comet_sections.feedback.story.feedback_context.feedback_target_with_context.subscription_target_id,
							creation_time: (new Date(+JSON.stringify(item.node).match(/(?<=creation_time":\s?)\d+/g)[0] * 1000))
						}) : "", ar), [])
					}))
			},
			notification: (groupId, postId, follow) => this.query.misc({
				// follow || 0 -> Turn Off notification | 1 -> turn on notification
				url: "https://www.facebook.com/ajax/litestand/follow_group_post",
				bdy: {
					group_id: groupId,
					message_id: postId,
					follow: follow
				}
			})
		},
		topics: {
			add: (groupId, topic) => this.query.misc({
				url: `https://www.facebook.com/groups/post_tag/add/dialog/`,
				bdy: {
					group_id: groupId,
					tag_name: topic,
					dom_id: `${groupId}_group_tab_post_tags`
				}
			}),
			delete: (groupId, topicId) => this.query.misc({
				url: "https://www.facebook.com/groups/post_tag/manage_tag/delete_tag/confirmed/",
				bdy: {
					group_id: groupId,
					post_tag_id: topicId,
					order: "ranked",
					query_term: "",
					search_one_item: 0,
					dom_id: `${groupId}_group_tab_post_tags`,
					"nctr[_mod]": "pagelet_group_admin_activities",
					confirmed: 1
				}
			}),
			edit: (groupId, topicId, topic) => this.query.misc({
				url: `https://www.facebook.com/groups/post_tag/manage_tag/edit_save/`,
				bdy: {
					group_id: groupId,
					tag_name: topic,
					post_tag_id: topicId,
					order: "ranked",
					query_term: "",
					one_item: false,
					dom_id: `${groupId}_group_tab_post_tags`
				}
			})
		},
		follow: (groupId, follow) => this.query.misc({
			// follow || 1 -> Unfollow | 0 -> Follow
			url: "https://www.facebook.com/groups/membership/unfollow_group/",
			bdy: {
				group_id: groupId,
				unfollow: follow
			}
		})
	}
	friends = {
		request: (userId, act = false) => this.query.misc({
			// act = true => accept request | false => reject
			url: "https://www.facebook.com/requests/friends/ajax/",
			bdy: {
				action: (act) ? "confirm" : "reject",
				id: userId
			}
		}),
		list: (userId, cursor) => {
			let vr = {
					count: 8,
					cursor,
					scale: 1,
					search: null,
					id: btoa(`app_collection:${userId}:2356318349:2`)
				};
			return this.query.graphql({
				fb_api_req_friendly_name: "ProfileCometAppCollectionListRendererPaginationQuery",
				doc_id: 5042924155825294,
				variables: JSON.stringify(vr),
			}).then((res) => {
				let jso = JSON.parse(res).data.node.pageItems,
					hashTable = {},
					result = {
						page_info: jso.page_info,
						items: [],
					};
				for (let item of jso.edges) {
					if (!hashTable[item.node.id]) {
						hashTable[item.node.id] = true;
						let profileOwner = item.node.actions_renderer.action.client_handler.profile_action.restrictable_profile_owner,
							mem = {
								name: item.node.title.text || profileOwner.name,
								url: item.node.url,
								id: profileOwner.id,
								gender: profileOwner.gender,
								short_name: profileOwner.short_name,
								friendship_status: profileOwner.friendship_status,
							};
						result.items.push(mem);
					}
				}
				return result;
			})
		},
	}
	me = {
		block: {
			page: (pageId) => this.query.misc({
				url: "https://www.facebook.com/privacy/block_page/",
				bdy: {
					confirmed: 1,
					page_id: pageId
				}
			}),
			user: (userId) => this.query.misc({
				url: "https://www.facebook.com/ajax/privacy/block_user.php",
				bdy: {
					confirmed: 1,
					uid: userId
				}
			})
		},
		poke: (userId) => this.fet({ url: `https://www.facebook.com/pokes/dialog/?poke_target=${userId}`, }),
		post: {
			delete: async (postId) => this.query.misc({
				url: `https://www.facebook.com/ajax/timeline/delete?${this.conv.query({
					identifier: `S:_I${await this.get.local().me}:${postId}`,
					is_notification_preview: 0,
					location: 9,
					render_location: 10
				})}`,
			}),
			notification: (postId, follow = 1) => this.query.misc({
				// follow = 0 -> Turn Off notification | 1 -> turn on notification
				url: "https://www.facebook.com/ajax/litestand/follow_post",
				bdy: {
					message_id: postId,
					follow: follow
				}
			})
		},
		unblock: (userId) => this.query.misc({
			url: "https://www.facebook.com/privacy/unblock_user/",
			bdy: {
				privacy_source: "privacy_settings_page",
				uid: userId
			}
		}),
		unfollow: (userId) => this.query.misc({
			url: "https://www.facebook.com/ajax/follow/unfollow_profile.php",
			bdy: {
				"nctr[_mod]": "pagelet_collections_following",
				location: 4,
				profile_id: userId
			}
		}),
		unfriend: (userId) => this.query.misc({
			url: "https://www.facebook.com/ajax/profile/removefriendconfirm.php",
			bdy: {
				confirmed: 1,
				uid: userId
			}
		})
	}
	page = {
		inviteLike: (pageId, invitees, inviteMsg) => this.query.misc({
			url: "https://www.facebook.com/pages/batch_invite_send/",
			bdy: {
				invite_note: inviteMsg,
				page_id: pageId,
				ref: "modal_page_invite_dialog_v2",
				send_in_messenger: false,
				...(Array.isArray(invitees) ? invitees : [invitees]).reduce((current, item, index) => ({...current, [`invitees[${index}]`]: item}), {})
			}
		}),
		like: async (pageId, like = false) => this.query.misc({
			// like || true -> like page | false -> Unlike
			url: `https://www.facebook.com/ajax/pages/fan_status.php?av=${await this.get.local.me()}`,
			bdy: {
				actor_id: myId,
				add: orNot,
				fbpage_id: pageId,
				reload: false
			}
		})
	}
	post = {
		getReactions: (postId, cursor) => {
			// Faster way
			// https://graph.facebook.com/reactions?access_token={token}&ids={postId,...}&field=id&limit=1000
			let feedbackId = btoa(`feedback:${postId}`),
				vr = {
					count: 10, // fixed, can't change
					cursor: cursor,
					feedbackTargetID: feedbackId,
					reactionID: null,
					reactionType: "NONE",
					scale: 1,
					stagesSessionID: null,
					id: feedbackId
				};
			return this.query.graphql({
				fb_api_req_friendly_name: "CometUFIReactionsDialogTabContentRefetchQuery",
				doc_id: 8013121342046989,
				variables: JSON.stringify(vr),
			}).then((res) => {
				let jso = JSON.parse(res).data.node.reactors,
					hashTable = {},
					result = {
						page_info: jso.page_info,
						items: [],
					};
				for (let item of jso.edges) {
					if (!hashTable[item.node.id]) {
						hashTable[item.node.id] = true;
						let mem = {
							id: item.node.id,
							name: item.node.name,
							url: item.node.profile_url,
						};
						result.items.push(mem);
					}
				}
				return result;
			})
		},
		react: (postId, reactType) => this.query.misc({
			// Reaction {none: 0, like: 1, love: 2, wow: 3, haha: 4, sad: 7, angry: 8, care: 16}
			url: "https://www.facebook.com/ufi/reaction/",
			bdy: {
				client_id: "1489983090155:3363757627",
				ft_ent_identifier: postId,
				reaction_type: reactType,
				session_id: "84d81e4",
				source: 2
			}
		}),
	}
	upload = async (blob) => {
		let f = await {
			"attachment[]": blob,
			fb_dtsg: this.get.local().dtsg,
			...((blob.type.includes("image")) ? ({image_only: true}) : ""),
			...((blob.type.includes("audio")) ? ({voice_clip: true}) : ""),
			...((blob.type.includes("text")) ? ({file_only: true}) : ""), // I'm just predicting this is it. Idk is it true btw =.=
		}, fd = new FormData();
		for (let key in f) fd.append(key, f[key]);

		return this.query.misc({
			url: `https://upload.facebook.com/ajax/mercury/upload.php?fb_dtsg=${encodeURIComponent(f.fb_dtsg)}&__a=1`,
			bdy: fd
		}).then((e) => JSON.parse(e.replace(/^[^\{]+/g, "")).payload.metadata);
	}
}

window.fbTools = new FBTools();

console.log(fbTools);
function cannedRes() {
	let input = document.createElement("input"),
		f = new FileReader(),
		canned = document.querySelector("#cannedRes"),
		utId = document.URL.match(/\d+$/g),
		grUsr = (!!Array.from(document.querySelectorAll("span[dir='auto']")).filter((a) => /chat\smembers/gi.test(a.innerHTML)).length) ? "thread" : "user";
	input.type = "file";
	input.accept = "audio/*,image/*,video/*,text/*";
	input.setAttribute("id", "fbTools")
	input.onchange = function(e) {
		let res = e.path.pop().files[0];
		f.onloadend = function(c) {
			let blob = new Blob([c.target.result], {type: res.type});
			canned.innerHTML = `CR: ~${(blob.size / (1024*1024)).toFixed(2)} MB(s) | ${blob.type} | ${utId}`;
			fbTools.upload(blob).then((r) => {
				let res = r[0], typ = res.filetype.match(/\w+/g)[0],
					obj = {};
				obj[grUsr] = utId.pop();
				obj[typ] = res[`${typ}_id`];
				canned.innerHTML = `CR: Received ${obj[typ]}`;
				fbTools.conversation.send(obj);
				canned.innerHTML = "Canned Response";
			});
		};
		f.readAsArrayBuffer(res);
	}
	input.click();
}
let a = new DOMParser().parseFromString(`
<li class="buofh1pr to382e16 o5zgeu5y jrc8bbd0 dawyy4b1 bx45vsiw h676nmdw">
	<span class="tojvnm2t a6sixzi8 abs2jz4q a8s20v7p t1p8iaqh k5wvi7nf q3lfd5jv pk4s997a bipmatt0 cebpdrjk qowsmv63 owwhemhu dp1hu0rb dhp61c6y iyyx5f41">
		<div class="bp9cbjyn j83agx80 byvelhso l9j0dhe7">
			<a id="cannedRes" style="color: #FFF;">Canned Response</a>
		</div>
	</span>
</li>
`, "text/html").querySelector("li");
a.querySelector("a").onclick = cannedRes;
document.querySelector('[role="navigation"] > ul > li:last-child').parentElement.append(a);