((threadId) => {
	fetch("https://www.facebook.com/api/graphqlbatch/", {
		"headers": {
			"content-type": "application/x-www-form-urlencoded, application/x-www-form-urlencoded",
			"sec-fetch-mode": "cors",
			"sec-fetch-site": "same-origin",
			"x-msgr-region": "ASH"
		},
		"body": `batch_name=MessengerGraphQLThreadFetcher&__user=${require("CurrentUserInitialData").USER_ID}&dpr=1&fb_dtsg=${require("DTSGInitialData").token}&queries=${encodeURIComponent(`{"o0":{"doc_id":"2979378038858642","query_params":{"id":"${threadId}","message_limit":1,"load_messages":false,"load_read_receipts":false,"load_delivery_receipts":false,"is_work_teamwork_not_putting_muted_in_unreads":false}}}`)}`,
		"method": "POST",
		"mode": "cors",
		"credentials": "include"
	}).then((a) => a.text()).then((a) => a.replace(/\{"success.*/g, "")).then((a) => {
		console.log( JSON.parse(a).o0.data.message_thread.all_participants.edges.map((a) => a.node.messaging_actor.id) );
	});
})(123123123); // Thread ID Here