let dead = [],
	arr = [123, 2345];
	arr.reduce((cp, id, index, {length: arr}) => cp.then((a) => new Promise((resolve) => {
		fetch(`https://www.pixiv.net/ajax/user/${id}/profile/all`).then((b) => b.json()).then((b) => {
			console.log(`Fetched #${id} || ${index + 1} / ${arr} || ${(b.error) ? `Dead. Message: ${b.message}` : `Alive`}`);
			(b.error) ? dead.push(id) : "";
			resolve();
		});
	})), Promise.resolve()).finally(() => console.log(dead));