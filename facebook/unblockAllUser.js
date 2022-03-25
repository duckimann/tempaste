/** 
 *? Use this with the fbTools repository
 * Open https://www.facebook.com/settings?tab=blocking
 * Run the fbTools.js first
 * then scroll all the way down to show all the currently blocked user
 * then run this script.
*/
Array.from(document.querySelectorAll("input[name='uid']"), (a) => a.value)
	.reduce((cp, uid) => new Promise((res) => {
		fbTools.me.unblock(uid).then((unblocked) => {
			setTimeout(() => res(), 500);
		})
	}), Promise.resolve())
	.finally(() => console.log("Done."));