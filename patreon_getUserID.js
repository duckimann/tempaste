// https://patreon.com/user?u={uid}
// https://patreon.com/CodeBullet

javascript: !(() => window.prompt("Patreon User ID", (patreon.bootstrap.creator || patreon.bootstrap.campaign).data.relationships.creator.data.id))();

// Bulk version
// How to use: Fill the array as shown -> open "patreon.com" -> F12 -> Console
let db = [
	"sakimichan",
	"HongBsWs",
	"tofuubear",
	"nanoless"
],
	result = [];
db.reduce((cp, item, index, arr) => cp.then(() => new Promise((res) => {
	console.log(`${index + 1}/${arr.length} || ${item}`);
	fetch(`/${item}`)
	.then((a) => a.text())
	.then((a) => +a.match(/(?<=api\/user\/)\d+/g)[0])
	.then((a) => {
		console.log(`Found ID: ${a}`);
		result.push(a);
		setTimeout(res, 2000);
	});
})), Promise.resolve());
