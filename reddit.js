function fetdit(sub, after) {
	return fetch(`https://www.reddit.com/r/${sub}/new.json?limit=100${ (after) ? `&after=${after}` : ""}`)
		.then((a) => a.json())
		.then(({ data: a }) => {
			let results = {
				after: a.after,
				children: a.children.map((b) => ({ id: b.data.id, permalink: b.data.permalink, thumbnail: b.data.thumbnail })).filter((b) => b.thumbnail.includes(".jpg"))
			};
			return results;
		})
}
(async () => {
	let res = await fetdit("Sweatymoe Pixiv AzureLane twintails".replace(/\s+/g, "+"));
	console.log(res);
})();
