((user, select) => {
	// Get from bookmarks or following
	// Select = 0 || 1
	if (!user) {
		console.error("Error: You Must Fill In User ID.");
	} else {
		let global = {
			opt: ["bookmarks", "following"],
			offset: 0,
			results: [],
			user: user,
			get: function() {
				fetch(`https://www.pixiv.net/ajax/user/${this.user}/illusts/${this.opt[select]}?tag=&offset=${this.offset}&limit=100&rest=show`)
				.then((a) => a.json())
				.then((a) => new Promise((resolve, reject) => (!a.error) ? (delete a.body.zoneConfig, delete a.body.extraData, resolve(a.body)) : reject(a.message)))
				.then((a) => {
					console.log(a);
					for (let b of a.works) this.results.push(Number(b.userId));
					if (a.works.length !== 0) {
						this.offset += 100;
						this.get();
					} else {
						console.log(`Step 1/2: Fetch Users From ${this.opt[select]} List Of Given User.`, this.results);
						console.log("Step 2/2: Filtering Users Just Got Fetched With Large DB.", Array.from(new Set(this.results.map((b) => Number(b)))));
					}
				})
				.catch((a) => console.log("Error: %s", a));
			}
		};
		global.get();
	}
})(24935781, 0)