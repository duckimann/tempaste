arr.reduce((cp, item, index, arr) =>
	cp.then((b) =>
		new Promise((resolve) =>
			fetch(`https://www.pixiv.net/ajax/illust/${item}`)
			.then((c) => c.json())
			.then((c) => (c.error) ? (console.log(`${index + 1}/${arr.length} | ${item} | Error Occurred | Message: ${c.message} | Forwarding...`), resolve(a)) : c.body.tags.authorId)
			.then((c) => Number(c))
			.then((c) => (![...b].includes(c)) ? ((typeof(c) !== "undefined") ? (console.log(`${index + 1}/${arr.length} | ${item} (Work ID) => ${c} (User ID) | Database: Not Exists | Adding...`), b.push(c), resolve(b)) : "") : (console.log(`${index + 1}/${arr.length} | ${item} (Work ID) => ${c} (User ID) | Database: Exists | Forwarding...`), resolve(b)))
		)
	), Promise.resolve([])
).then((b) => console.log("Done.", b));