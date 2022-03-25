((scode) => {
	let vari = {
		"shortcode": scode,
		"child_comment_count": 0,
		"fetch_comment_count": 0,
		"parent_comment_count": 0,
		"has_threaded_comments": false
	};
	fetch(`https://www.instagram.com/graphql/query/?${Object.keys(vari).map((key) => `${key}=${vari[key]}`).join("&")}&query_hash=2efa04f61586458cef44441f474eee7c`)
		.then((res) => res.json())
		.then((res) => (res.data.shortcode_media.is_video) ? res.data.shortcode_media.video_url : res.data.shortcode_media.edge_sidecar_to_children.edges.map((item) => item.node.display_url))
		.then(console.log)
})("CUXKXPDN4Ia"); // can get video, photos, reel (@ profile)