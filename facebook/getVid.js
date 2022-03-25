((vidId) => {
	fetch(`https://www.facebook.com/video/tahoe/async/${vidId}/?originalmediaid=${vidId}&playerorigin=unknown&playersuborigin=unknown&numcopyrightmatchedvideoplayedconsecutively=0&payloadtype=primary`, {
		headers: {
			"accept": "*/*",
			"accept-language": "en-US,en;q=0.9",
			"content-type": "application/x-www-form-urlencoded",
		},
		body: `__a=1&fb_dtsg=${require("DTSGInitialData").token || document.querySelector('[name="fb_dtsg"]').value}`,
		method: "POST",
		mode: "cors",
		credentials: "include"
	})
	.then((a) => a.text()).then((a) => a.replace("for (;;);", "")).then((a) => JSON.parse(a))
	.then((a) => {
		let jsmods = a.jsmods,
			result = {};
		// 720p
		for (let item of jsmods.instances) {
			if (item[1]?.[0] == "VideoConfig") {
				let {hd_src, sd_src_no_ratelimit} = item[2][0].videoData[0];
				result["720"] = { hd_src, sd_src_no_ratelimit };
			};
		};
		// 1080p (but it's faked, i checked the downloaded video, it's roughly larger than 720p a bit)
		for (let item of jsmods.require) {
			if (item[1] == "loadVideo") {
				let vid = item[3][0];
				result["1080"] = { audio: vid.audio[0].url, video: vid.video[1].url };
			};
		};
		console.log(result);
	});
})(123); // video id here

// Prototype using GraphQL
((vidId, mediasetToken) => {
	fetch("https://www.facebook.com/api/graphql/", {
		method: "POST",
		credentials: "include",
		headers: {
			"Content-Type": "application/x-www-form-urlencoded"
		},
		body: `fb_dtsg=${(require("DTSGInitialData").token || document.querySelector('[name="fb_dtsg"]').value)}&fb_api_caller_class=RelayModern&fb_api_req_friendly_name=CometVideoRootMediaViewerQuery&variables={"UFI2CommentsProvider_commentsKey":"CometVideoRootMediaViewerQuery","displayCommentsContextEnableComment":null,"displayCommentsContextIsAdPreview":null,"displayCommentsContextIsAggregatedShare":null,"displayCommentsContextIsStorySet":null,"displayCommentsFeedbackContext":null,"feedLocation":"COMET_MEDIA_VIEWER","feedbackSource":65,"focusCommentID":null,"isMediaset":true,"loopMedia":false,"mediasetToken":"${mediasetToken}","nodeID":"${vidId}","privacySelectorRenderLocation":"COMET_STREAM","renderLocation":"permalink","scale":1,"useDefaultActor":false}&server_timestamps=true&doc_id=3881870738514115`,
	})
	.then((a) => a.text())
	.then((a) => a.split("\n").map((b) => JSON.parse(b)))
	.then((a) => console.log(a));
})(1502301343296187, "pcb.3497698823639031"); // video id & mediasetToken here
// https://www.facebook.com/100005490069437/videos/pcb.3497698823639031/1502301343296187/

// The official way (using graph.facebook.com)
// https://graph.facebook.com/v8.0/{vidId}?fields=source&access_token={EAAAA...}