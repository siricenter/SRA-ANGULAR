$(document).on 'ready page:load', ->
  $(".sparkline-bar").each ->
    $el = $(@)
    #grab the color from data-color or default to danger
    color  = EmVars.colorFromName($el.data("color") || "danger")
    height = '18px'
    barWidth = '6px'
    barSpacing = '1px'
    height = '30px'

    $el.sparkline 'html',
      type: 'bar'
      barColor: color
      height: height
      barWidth: barWidth
      barSpacing: barSpacing
      zeroAxis: false