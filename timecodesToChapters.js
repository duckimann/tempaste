((chapters) => {
	new Promise((res) => {
		let items = chapters.split("\n").map((chapter, index) => {
			let info = chapter.split(" - "),
				time = info[0],
				title = info[1];
			++index;
			return `CHAPTER${index}=00:${time}.000\nCHAPTER${index}NAME=${title}`;
		});
		res(items.join("\n"));
	}).then((a) => {
		console.log(a);
		let blob = new Blob([a], {type: "plain/text"}),
			aTag = document.createElement("a");
		aTag.href = URL.createObjectURL(blob);
		aTag.download = "chapter.txt";
		aTag.click();
	});
})(`00:00 - Intro
00:55 - The Shortstop
03:02 - Shortstop Slows
03:39 - Behind The 8 Ball
06:15 - 8 Ball Slows
07:20 - The Z Choker
10:05 - Z Choker Zlows
10:45 - Full Combo
13:10 - Thanks Patrons!!`);
