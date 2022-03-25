let source = {
	allMem: [],
	whiteMem: [],
	limit: 10,
	status: 1, // set to 0 to stop
	kicked: 0,
	groupId: 0,
	isBlock: 0,
}

source.allMem.reduce((cp, id, index, {length: arr}) => cp.then(() => new Promise((res, rej) => {
	if (source.status === 0) return rej("User hit stop.");
	if (source.limit !== 0 && source.kicked >= source.limit) return rej("Hit limit.");
	if (source.whiteMem.includes(id)) {
		console.log(`${index +1}/${arr} || Kicked (Total): ${source.kicked}/${source.limit} || Whitelisted: ${id}`);
		return res();
	}
	fbTools.group.members.remove(source.groupId, id, source.isBlock).then((r) => {
		++source.kicked;
		console.log(`${index +1}/${arr} || Kicked (Total): ${source.kicked}/${source.limit} || Kicked: ${id}`);
		res();
	});
})), Promise.resolve()).catch(console.log).finally(() => console.log("Done."));
// use this script along with fbTools.js