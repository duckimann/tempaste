// Create a set of checkboxs value
chrome.runtime.onInstalled.addListener(() => {
	chrome.storage.local.set({
		contextMenus: {
			autoClose: true,
			autoCloseParent: false,
			autoSwitchNewTab: false,
		}
	});
});
// Main functions
var contextMenu = {
	create: (arr) => {
		for (let context of arr) chrome.contextMenus.create(context);
	},
	generate: (template, variants) => {
		// contextMenu.generate({type: "normal", id: "parentSearch"}, [{name: "saucenao", onclick: console.log("a")}, {name: "iqdb", onclick: console.log("b")}]);
		return variants.map((a) => ({...a, ...template}));
	},
	get: () => {
		chrome.storage.local.get("contextMenus", ({contextMenus: contexts}) => {
			for (let context in contexts) {
				dynamicVar[context] = contexts[context];
				chrome.contextMenus.update(context, { checked: contexts[context] });
			}
		});
	},
	save: (con) => {
		chrome.storage.local.get("contextMenus", ({contextMenus}) => {
			contextMenus[con.menuItemId] = con.checked;
			dynamicVar[con.menuItemId] = con.checked;
			chrome.storage.local.set({ contextMenus });
		});
	},
}, dynamicVar = {};

let contexts = [
	{ type: "normal", title: "Search With", id: "parentSearch", contexts: ["image", "link"] },
	{ type: "checkbox", title: "Switch To New Tab", parentId: "parentSearch", id: "autoSwitchNewTab", onclick: contextMenu.saveContexts, contexts: ["all"] },
	{ type: "separator", parentId: "parentSearch", contexts: ["all"] },
	{ type: "normal", title: "Ascii2D", parentId: "parentSearch", onclick: (a) => contextMenu.revSearch("ascii2d", a), contexts: ["all"] },
	// Inject Pre-defined script
	{ type: "normal", title: "Inject Script", id: "injectScript", contexts: ["all"] },
	// Others
	{ type: "radio", title: "In-DB Auto Close Tab", onclick: contextMenu.saveContexts, contexts: ["all"], id: "autoClose" },
	{ type: "radio", title: "In-DB Auto Close Parent Tab", onclick: contextMenu.saveContexts, contexts: ["all"], id: "autoCloseParent" },
];
contextMenu.create(contexts);