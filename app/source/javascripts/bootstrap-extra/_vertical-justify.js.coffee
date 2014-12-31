verticalJustifyCb = ->
  $verticalJustify = $('.vertical-justify')
  $verticalJustify.each ->
    $this = $(this)
    window.a = $this
    $children = $this.children()
    $children.css(height: $this.height() / $children.length)

$(window).on "load", verticalJustifyCb
$(document).on "page:load", verticalJustifyCb