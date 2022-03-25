/**
* Scroller.js v2
* Developed by me
* Styling by phananhdev@github
*/
var scr = `
<div id="scroller" align="center">
	<style>
	#scroller {
		position: fixed;
		height: 100vh;
		width: 100%;
		top: 0;
		z-index: 99999;
		background: rgba(0, 0, 0, .7);
	}
	h1 {
		color: #FFF;
		font-size: 2em;
	}
	#info {
		width: 40%;
		transform: translateY(50%);
		display: grid;
		grid-template-columns: 1fr 1fr;
		grid-template-rows: .5fr .5fr .5fr .5fr;
		gap: 1px 1px;
		grid-template-areas: "h1 h1" "direction timeout" "selector selector" "cancel btn";
	}
	.btn { grid-area: btn; }
	.cancel { grid-area: cancel; }
	.direction { grid-area: direction; }
	.h1 { grid-area: h1; }
	.selector { grid-area: selector; }
	.timeout { grid-area: timeout; }

	#info > select, #info > input {
		margin: .5vh 0;
		padding: 1vh;
		border-radius: 5px;
		border: 1px solid black;
		transition: 0.5s;
		font-size: 1.5em;
	}
	#info > select:focus, input:focus {
		outline: none;
		border: 1px solid #2979FF;
	}
	#cancel {
		background: #e82323;
		color: white;
		border: none;
	}
	#cancel:hover {
		background: white;
		color: #e82323;
		border: 1px solid #e82323;
	}
	#subm {
		background: #2979FF;
		color: white;
		border: none;
	}
	#subm:hover {
		background: white;
		color: #2979FF;
		border: 1px solid #2979FF;
	}
	</style>
	<div id="info">
		<div class="h1" align="center">
			<h1>Duckimann Scroller</h1>
		</div>
		<select class="direction" title="Scroll Direction">
			<option value="right">Right</option>
			<option value="left">Left</option>
			<option value="down" selected="">Down</option>
			<option value="up">Up</option>
		</select>
		<input class="timeout" type="number" title="Stop After ... Second(s)" min="0" value="0">
		<input class="selector" type="text" placeholder="(Optional) document.querySelectorAll()[0]" title="Use eval() to execute the querySelectorAll()">
		<input class="cancel" type="button" value="Cancel" id="cancel">
		<input class="btn" type="button" value="Start Scroll" id="subm">
	</div>
</div>
`,
	scroller = new DOMParser().parseFromString(scr, "text/html").querySelector("#scroller");
scroller.querySelector("#subm").onclick = function() {
	let data = this.parentElement.parentElement,
		spec = {
			direction: data.querySelector("select").value,
			selector: data.querySelector("input[type='text']").value,
			timeout: Number(data.querySelector("input[type='number']").value)
		},
		scrl = setInterval(function() {
			let num = 2000,
				sel = (spec.selector.includes("querySelector")) ? eval(spec.selector) : window;
			sel.scrollBy(
				(spec.direction == "right") ? num : (spec.direction == "left") ? -num : 0,
				(spec.direction == "down") ? num : (spec.direction == "up") ? -num : 0
			);
		}, 1000);
	setTimeout(function() {
		clearInterval(scrl);
		alert("Done.");
	}, spec.timeout * 1000 + 1000);
	document.querySelector("#scroller").remove();
};
scroller.querySelector("#cancel").onclick = function() {
	document.querySelector("#scroller").remove();
};
document.body.appendChild(scroller);