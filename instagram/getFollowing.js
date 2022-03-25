let intv = setInterval(() => {
	let following = +document.querySelector("a[href*='following'] > span").innerText,
		urls = document.querySelectorAll("a.FPmhX.notranslate._0imsa");

	if (!document.querySelector("div[role='dialog']")) document.querySelector("a[href*='following']").click();
	if (urls.length === following) {
		clearInterval(intv);
		Array.from(document.querySelectorAll("a.FPmhX.notranslate._0imsa")).reduce((cp, item) => cp.then((c) => new Promise((resolve) => {
			fetch(item.href)
				.then((a) => a.text())
				.then((a) => a.match(/(?<=profilepage_)\d+/gi)[0])
				.then((a) => {
					let data = {uid: +a, url: item.href};
					console.log(data);
					c.push(data);
					resolve(c);
				});
		})), Promise.resolve([])).then((a) => {
			let fl = document.createElement("a");
			fl.download = "insta.txt";
			fl.href = URL.createObjectURL(new Blob([a.map((b) => JSON.stringify(b)).join("\n")], {type: "text/plain"}));
			fl.click();
		});
	} else document.querySelector("div > ul").parentElement.scrollBy(0, 500);
}, 500);
// Open your profile then run this script (in devtools)

/* How to get User ID
1. Open user you want to get ID
2. Open DevTools => run script "window._sharedData.entry_data.ProfilePage[0].graphql.user.id" (Without the double quote)
*/

/* How to get username from uid:
1. Open "https://i.instagram.com/api/v1/users/uid/info/" (Modify "uid" to the uid that you have)
2. Change User-Agent to "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_3 like Mac OS X) AppleWebKit/603.3.8 (KHTML, like Gecko) Mobile/14G60 Instagram 12.0.0.16.90 (iPhone9,4; iOS 10_3_3; en_US; en-US; scale=2.61; gamut=wide; 1080x1920)"

Side-note: Extension to change Headers I'm using is "CDN Headers & Cookies"
*/