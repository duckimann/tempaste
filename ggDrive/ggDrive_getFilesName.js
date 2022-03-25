Array.from(document.querySelectorAll(".KL4NAf")).map((a) => a.innerHTML.match(/[^\.]+/g)[0]);

copy(Array.from(document.querySelectorAll(".KL4NAf")).map((a) => `https://danbooru.donmai.us/posts/${a.innerHTML.match(/[^\.]+/g)[0]}`).join("\n"));