const { createWriteStream } = require("fs"),
	file = createWriteStream(`${__dirname}/twmedia.txt`, {encoding: "utf8", flags: "a"}),
	fet = require("node-fetch"),
	fetch = (url) => fet(url, {
		timeout: 0,
		headers: {
			"Authorization": `Bearer ${auth.bearer_token}`,
			"Content-Type": "application/json",
			"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4128.3 Safari/537.36"
		}
	}).then((a) => a.json());

const auth = { // https://developer.twitter.com/en/portal/dashboard
	consumer_key: "",
	consumer_secret: "",
	access_token: "",
	token_secret: "",
	bearer_token: ""
};

function get({ uid, page }) {
	fetch(`https://api.twitter.com/2/users/${uid}/tweets?max_results=100&expansions=attachments.media_keys&media.fields=url,preview_image_url,height,width${ (page) ? `&pagination_token=${page}` : ""}`)
		.then((a) => {
			let token = a.meta.next_token;
			a.includes.media = a.includes.media.map((img) => (img.url = `${img.url}?name=orig`, img));
			console.log(a, token);
			file.write(`${JSON.stringify(a, null, "\t")}\n\n`);
			token && get({uid, page: token});
		});
}
get({ uid: 1163423515 });