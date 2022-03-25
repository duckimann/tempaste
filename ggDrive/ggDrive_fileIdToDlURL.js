((arrId) => {
	let driveApiKey = "AIzaSyDuPK2t8LMn67-BSmzrVpRi6JdRxEk8XZI";
	arrId.reduce((cp, id, index, arr) => cp.then((c) => new Promise((resolve) => {
		fetch(`https://www.googleapis.com/drive/v3/files/${id}?key=${driveApiKey}`)
		.then((d) => d.json())
		.then((d) => {
			console.log("Fetched %s/%s || %s", index + 1, arr.length, d.name);
			c.push(`"C:\\Program Files (x86)\\Internet Download Manager\\IDMan.exe" /d "https://www.googleapis.com/drive/v3/files/${d.id}?alt=media&key=${driveApiKey}" /f "${d.name}" /p "F:/" /a`);
			resolve(c);
		});
	})), Promise.resolve([]))
	.then((c) => (c.push("del dl.bat"), c.join("\n")))
	.then((c) => {
		let blob = new Blob([c], {type: "plain/text"}),
			aTag = document.createElement("a");
		aTag.href = URL.createObjectURL(blob);
		aTag.download = "dl.bat";
		aTag.click();
	});
})();