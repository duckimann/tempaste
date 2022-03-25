var elt = document.createElement("script");
elt.innerHTML = "window.foo = { bar: () => dataLayer[0].user_id };" // pixiv
document.head.appendChild(elt);

// Alternative
;(function() {
  function script() {
    // your main code here
    window.foo = 'bar'
  }

  function inject(fn) {
    const script = document.createElement('script')
    script.text = `(${fn.toString()})();`
    document.documentElement.appendChild(script)
  }

  inject(script)
})();