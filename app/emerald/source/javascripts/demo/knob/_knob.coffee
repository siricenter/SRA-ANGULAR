$(document).on 'ready page:load', ->
  $('.em-knob').each ->
    $el = $(@)
    #grab the color from data-color or default to info
    color = EmVars.colorFromName($el.data('color') || 'info')

    min = -50
    max = 50
    val = EmVars.rand(min, max)
    $el.val(val)

    $el.knob
      width: 100
      height: 100
      thickness: .2
      fgColor: color
      min: min
      max: max