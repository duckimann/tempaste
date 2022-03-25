(() => {
	let locations = {
		rss: document.querySelector("link[href*='channel_id']"),
		alternate: document.querySelector("link[href*='channel/']").href.match(/[^\/]*$/g)[0]
	};
	console.log(locations);
	window.prompt("Channel ID:", (locations.rss == locations.alternate) ? (new URL(locations.rss.href)).searchParams.get("channel_id") : locations.alternate);
})();