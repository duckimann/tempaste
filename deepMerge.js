// Merge a `source` object to a `target` recursively
const merge = (target, source) => {
	// Iterate through `source` properties and if an `Object` set property to merge of `target` and `source` properties
	for (const key of Object.keys(source)) {
		if (source[key] instanceof Object) Object.assign(source[key], merge(target[key], source[key]));
	} 
	// Join `target` and modified `source`
	Object.assign(target || {}, source);
	return target;
}

// minified
const merge=(t,s)=>{const o=Object,a=o.assign;for(const k of o.keys(s))s[k]instanceof o&&a(s[k],merge(t[k],s[k]));return a(t||{},s),t}
