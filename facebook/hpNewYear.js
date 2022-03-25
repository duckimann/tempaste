/* How It Works
Friends list
=> Remove exclude
=> Loops though friends list (After reach execute time)
	=> If in special => Send specials
	=> Not in special => Send popular
==> Only run in 1 minute (Part: Send message)
Require fbTools.js
*/
const executeTime = "Feb 05 2020 00:00:00", // When script reach this date, execute function and exit.
	fList = [], // Friends list here.
	exclude = [], // Friends will be exclude, no wish here.
	special = {
		// userId: ["loi chuc 1", "loi chuc 2", 123, "loi chuc x"] // If value = string -> Message else if value = number -> sticker
	}, // Special ID + Wishes here
	specialList = Object.keys(special).map((a) => +a),
	popularWish = "🎆 Chúc mừng năm mới 🎆";

// Make sure typeof ID == Number
fList = fList.map((a) => +a);
exclude = exclude.map((a) => +a);
// Remove Exclude
for (let id of exclude) fList.splice(fList.indexOf(id), 1);

function action() {
	let rush = new Date(executeTime.replace(/(?<=:.)\d(?=:)/g, 1)).getTime(); // Set rush time = 1 minute
	fList.reduce((cp, id, index, {length: arr}) => cp.then((a) => new Promise((res, rej) => {
		let timeLeft = (rush - (new Date().getTime())),
			isSpecial = specialList.includes(id);
		if (timeLeft <= 0) rej();
		else {
			console.log(`Time Left: ${new Date(timeLeft).getSeconds()} || ${index + 1}/${arr} || UID: ${id} || Is ${(isSpecial) ? `In Special List. Sending Special Wishes... || ${JSON.stringify(special[id])}` : `Not In Special List. Sending Popular Wishes...`}`);
			if (isSpecial) {
				special[id].reduce((p2, d) => p2.then((e) => fbTools.conversation.chat({
					user: id,
					...(typeof(d) == "number") ? ({sticker: d}) : ({message: d})
				})), Promise.resolve()).finally(() => res());
			} else fbTools.conversation.chat({user: id, message: popularWish}).finally(() => res());
		}
	})), Promise.resolve()).finally(() => console.log("Mission Accomplished."));
}

let interval = setInterval(() => {
	let now = new Date().getTime(),
		time = new Date(executeTime).getTime(),
		distance = Math.floor((time - now) / 1000);

	console.log(`Estimated Time: ${distance} second(s)`);
	if (distance <= 0) {
		console.log("Timer End. Starting Mission.");
		clearInterval(interval);
		action();
	}
});