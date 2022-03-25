(() => {
	let autoClicker = {
		clicked: -1,
		lastStreamer: "",

		checkStreamer: () => {
			let path = (new URL(document.URL)).pathname,
				isDiffer = (autoClicker.lastStreamer !== path);

			if (isDiffer && autoClicker.clicked > -1) autoClicker.clicked = -1;
			if (autoClicker.clicked == -1) autoClicker.newObserve();
			if (isDiffer) autoClicker.lastStreamer = path;
		},
		addClick: () => {
			++autoClicker.clicked;
			document.querySelector("#chat-room-header-label").innerHTML = `# Click: ${autoClicker.clicked}`;
		},
		newObserve: () => {
			console.log("New observer");
			autoClicker.addClick();
			let observer = new MutationObserver((list) => {
				setTimeout(autoClicker.claimBonus, 3000);
			});
			observer.observe(document.querySelector("div[data-test-selector='community-points-summary']"), { attributes: true, childList: true, subtree: true }); // Start Observe
		},
		claimBonus: () => {
			let bonusBtn = document.querySelector("[aria-label='Claim Bonus']");
			if (bonusBtn) {
				bonusBtn.click();
				autoClicker.addClick();
			}
		},
	};

	autoClicker.checkStreamer();
	document.querySelector(".top-nav__prime").remove();
	setInterval(() => {
		console.log("Check streamer cycle.");
		autoClicker.checkStreamer();
	}, 30 * 1000);
})();