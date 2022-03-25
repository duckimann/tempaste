(function(history){
    let pushState = history.pushState;
    history.pushState = function(state) {
      // YOUR CUSTOM HOOK / FUNCTION
		console.log('I am called from pushStateHook');
		return pushState.apply(history, arguments);
    };
})(window.history);