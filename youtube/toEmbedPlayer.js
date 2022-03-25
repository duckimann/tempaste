((source, loop) => {
	let vidId = source.searchParams.get("v"),
		result = `${source.origin}/embed/${vidId}&autoplay=1${ (loop) ? `&loop=1&playlist=${vidId}` : "" }`;
	if ( !result.includes("?") ) result = result.replace("&", "?");
	document.location.href = result;
})(new URL(document.location.href), true);