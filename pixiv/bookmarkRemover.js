((user) => {
	let global = {
		offset: 0,
		results: [],
		totalUsrLimit: 900,
		user: user,
		remove: () => {
			let splitter = [];
			if (global.results.length > global.totalUsrLimit) {
				for (let a = 0, b = global.results.length, c = global.totalUsrLimit; a < b; a += c) splitter.push(global.results.slice(a, a + c));
			} else splitter = [global.results];
			console.log(`Found ${global.results.length} Works | Splitted to ${splitter.length} Array(s)`);
			splitter.reduce((cp, items) => cp.then((sd) => new Promise((resolve) => {
				fetch("/bookmark_setting.php", {
					method: "POST",
					credentials: "include",
					headers: {
						"Content-Type": "application/x-www-form-urlencoded",
						"Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
						"Cookie": `${document.cookie}; Upgrade-Insecure-Requests: 1`
					},
					body: `type=&tt=${pixiv.context.token}&tag=&untagged=0&rest=show&p=1&order=&${items.map((b) => encodeURI(`book_id[]=${b}`)).join("&")}&add_tag=&del=Remove+Selected`
				}).then((a) => (a.ok) ? setTimeout(() => resolve(), 3000) : alert("Failed."));
			})), Promise.resolve()).finally(() => {
				window.location.reload();
			});
		},
		get: function() {
			fetch(`https://www.pixiv.net/ajax/user/${this.user}/illusts/bookmarks?tag=&offset=${this.offset}&limit=100&rest=show`)
			.then((a) => a.json())
			.then((a) => new Promise((resolve, reject) => (!a.error) ? (delete a.body.zoneConfig, delete a.body.extraData, resolve(a.body)) : reject(a.message)))
			.then((a) => {
				for (let b of a.works) this.results.push(Number(b.bookmarkData.id));
				if (a.works.length !== 0) {
					this.offset += 100;
					this.get();
				} else this.remove();
			}).catch((a) => alert(`Error: ${a}`));
		}
	};
	global.get();
})(dataLayer[0].user_id);