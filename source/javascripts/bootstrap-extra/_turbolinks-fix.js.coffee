# http://carlosbecker.com/posts/turbolinks/

reloadImages = ->
  styles = Array::slice.call(document.body.querySelectorAll("[style]"))
  for el in styles
    style = el.getAttribute("style")
    continue unless style.indexOf("url(") > -1
    url = style.match(/url\((.*)\)/)[1]
    el.style.backgroundImage = "url(" + url + ")"

$(document).on "page:change", reloadImages
