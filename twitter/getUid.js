class TwitterUID {
	#headers;
	#required(name) {
		throw Error(`Parameter ${name} is required.`);
	}
	#fetch(url) {
		return fetch(url, this.#headers).then((res) => res.json());
	}

	constructor(bearer = this.#required("bearer"), csrf = this.#required("csrf")) {
		this.#headers = {
			"headers": {
				"authorization": bearer, // Should looks like: "Bearer AAAA"
				"content-type": "application/json",
				"sec-ch-ua": "\"\\\\Not;A\\\"Brand\";v=\"99\", \"Google Chrome\";v=\"85\", \"Chromium\";v=\"85\"",
				"sec-ch-ua-mobile": "?0",
				"x-csrf-token": csrf, // Change csrf token here
				"x-twitter-active-user": "yes",
				"x-twitter-auth-type": "OAuth2Session",
				"x-twitter-client-language": "en"
			},
			"referrer": "https://twitter.com/",
			"referrerPolicy": "no-referrer-when-downgrade",
			"body": null,
			"method": "GET",
			"mode": "cors",
			"credentials": "include"
		};
	}

	static getUid() {
		// Get UID using banner / follow button
		// Only available when you open their profile page
		let places = {
			"banner_photo": document.querySelector("div[style*='banner']")?.style.backgroundImage.match(/(?<=banners\/)\d+/g)[0],
			"show_more": (new URL(document.querySelector("a[href*='connect']").href)).searchParams.get("user_id"),
		}
		window.prompt("UID:", places.banner_photo || places.show_more);
	}

	toUid(screenName = this.#required("screenName")) {
		return this.#fetch(`https://api.twitter.com/graphql/cYsDlVss-qimNYmNlb6inw/UserByScreenName?variables=${ encodeURIComponent(JSON.stringify({"screen_name": screenName, "withHighlightedLabel": true})) }`)
			.then((res) => res.data.user.rest_id);
	}

	toScreenName(uid = this.#required("uid")) {
		// UID -> Screen Name
		// https://twitter.com/intent/user?user_id={uid}
		return this.#fetch(`https://twitter.com/i/api/graphql/caDIulm1UEkHEIL3uqYv8w/UserByRestId?variables=${ encodeURIComponent(JSON.stringify({"userId": uid, "withSafetyModeUserFields": false, "withSuperFollowsUserFields": false})) }`)
			.then((res) => res.data.user.result.legacy.screen_name);
	}

	fromTweet(tweetId = this.#required("tweetId")) {
		let variables = {
			"focalTweetId": tweetId,
			"with_rux_injections": false,
			"includePromotedContent": false,
			"withCommunity": false,
			"withTweetQuoteCount": false,
			"withBirdwatchNotes": false,
			"withSuperFollowsUserFields": false,
			"withUserResults": true,
			"withBirdwatchPivots": false,
			"withReactionsMetadata": false,
			"withReactionsPerspective": false,
			"withSuperFollowsTweetFields": false,
			"withVoice": false
		};
		return this.#fetch(`https://twitter.com/i/api/graphql/4tzuTRu5-fpJTS7bDF6Nlg/TweetDetail?variables=${encodeURIComponent(JSON.stringify(variables))}`)
			.then((res) => res.data.threaded_conversation_with_injections.instructions[0].entries[0].content.itemContent.tweet_results.result.core.user_results.result)
			.then((res) => ({id: res.rest_id, screen_name: res.legacy.screen_name}));
	}
}

// Methods
TwitterUID.getUid();

var tw = new TwitterUID("Bearer AAA", ""); // new TwitterUID(bearter_token, x-csrf_token);
tw.toUid("mimichan259").then(console.log);
tw.toScreenName("768792123214671873").then(console.log);
tw.fromTweet("1442786157260066818").then(console.log);