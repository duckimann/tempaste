// There is a rate limit. But i'm not sure does it at 400 req per hour?
let source = [],
	dead = [],
	continues = true;

function get(index) {
	let user = source[index];
	console.log(`${index}/${source.length} | Fetching Account ${user}`);
	fetch(`https://api.twitter.com/graphql/-xfUfZsnR_zqjFd-IfrN5A/UserByScreenName?variables=${ encodeURIComponent(JSON.stringify({"screen_name":user,"withHighlightedLabel":true})) }`, {
		"headers": {
			"authorization": "Bearer AAAA", // change your token here
			"content-type": "application/json",
			"sec-ch-ua": "\"\\\\Not;A\\\"Brand\";v=\"99\", \"Google Chrome\";v=\"85\", \"Chromium\";v=\"85\"",
			"sec-ch-ua-mobile": "?0",
			"x-csrf-token": "", // Change csrf token here
			"x-twitter-active-user": "yes",
			"x-twitter-auth-type": "OAuth2Session",
			"x-twitter-client-language": "en"
		},
		"referrer": "https://twitter.com/",
		"referrerPolicy": "no-referrer-when-downgrade",
		"body": null,
		"method": "GET",
		"mode": "cors",
		"credentials": "include"
	}).then((a) => (/^2/g.test(a.status)) ? a.json() : (continues = false)).then((a) => {
		if (a.errors) {
			console.log(`%cAccount ${user} | Err: ${a.errors}`, "color: red;");
			dead.push(user);
		}
		if (a.data?.user?.legacy?.protected) {
			console.log(`%cAccount ${user} are protected`, "color: red;");
			dead.push(user);
		}
		if (continues) get(++index);
	});
}
get(0);
