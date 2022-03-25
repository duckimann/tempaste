/* 
* Modified from script
* https://github.com/Nagai-Nano/user-scripts/blob/master/customSoundNotif.min.js
*/
var a = {
	send: XMLHttpRequest.prototype.send,
	open: XMLHttpRequest.prototype.open,
};

XMLHttpRequest.prototype.open = function(b, c) {
	a.open.apply(this, arguments);
}
XMLHttpRequest.prototype.send = function(d, e) {
	a.send.apply(this, arguments);
	if (d !== a.f && d.includes("thread_ids")) {
		let f = d.match(/(?<=thread_ids\[)\d+(?=\])/g)[0];
		a.f = d;
		console.log("You've got a new message from %s", f);
	}
}