// From https://github.com/sibu-github/deep-parse-json/blob/master/index.js

"use strict";
/**
 * [Recursively parses a stringified JSON]
 * @param  {[type]} jsonString [stringified json to parse]
 * @return {[type]}            [normalized Javascript object]
 */

const isNumString = (str) => !isNaN(Number(str));
function deepParseJson(jsonString) {
	// if not stringified json rather a simple string value then JSON.parse will throw error
	// otherwise continue recursion
	if (typeof jsonString === "string") {
		if (isNumString(jsonString)) {
			// if a numeric string is received, return itself
			// otherwise JSON.parse will convert it to a number
			return jsonString;
		}
		try {
			return deepParseJson(JSON.parse(jsonString));
		} catch (err) {
			return jsonString;
		}
	} else if (Array.isArray(jsonString)) {
		// if an array is received, map over the array and deepParse each value
		return jsonString.map((val) => deepParseJson(val));
	} else if (typeof jsonString === "object" && jsonString !== null) {
		// if an object is received then deepParse each element in the object
		// typeof null returns 'object' too, so we have to eliminate that
		return Object.keys(jsonString).reduce((obj, key) => {
			const val = jsonString[key];
			obj[key] = isNumString(val) ? val : deepParseJson(val);
			return obj;
		}, {});
	} else {
		// otherwise return whatever was received
		return jsonString;
	}
}

module.exports = { deepParseJson };
