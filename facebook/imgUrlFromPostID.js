((grId, pId, token) => {
	fetch(`https://graph.facebook.com/v3.1/${grId}_${pId}?fields=attachments{subattachments.limit(100)}&access_token=${token}`)
	.then((a) => a.json())
	.then((a) => a.attachments.data[0].subattachments.data.map((b) => b.media.image.src))
	.then((a) => {
		for (let b of a) chrome.tabs.create({
			url: `http://saucenao.com/search.php?db=999&url=${encodeURIComponent(b)}`,
			selected: false
		});
	});
})("Group ID Here", "Post ID Here", "AccessToken Here");