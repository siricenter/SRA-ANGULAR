$(document).on 'ready page:load', ->

  falseOrDefault = (el, def, value) ->
    return false if value == 'false'
    return value || def

  $(".easy-pie-chart-normal").each ->
    $el = $(@)
    #we default the color to info (light blue)
    color = EmVars.colorFromName($el.data('color') || 'info')

    #if we have a data-size attribute on the element, we set that, and we default to 150px
    size = $el.data('size') || 150

    #same thing, either data-line-width or 15px
    lineWidth = $el.data('line-width') || 15

    #for the track color we offer the choice of not having it at all, having a preset, or a default
    #so you can do data-track-color=false (will not render the track), data-track-color=something (will use that something), data-track-color='' (will default to #f2f2f2)
    trackColor = falseOrDefault($el, '#f2f2f2', $el.data('track-color'))

    #same thing here for the scaleColor (data-scale-color), only we use textColor as a default
    scaleColor = falseOrDefault($el, EmVars.colors.textColor, $el.data('scale-color'))

    #and run the chart
    $el.easyPieChart
      lineWidth: lineWidth
      size: size
      lineCap: "square"
      barColor: color
      scaleColor: scaleColor
      animate: 1000
      trackColor: trackColor

  #for random animations. you probably won't need this but feel free to use it as you see fit
  $(".easy-pie-chart-percent").easyPieChart
    animate: 1000,
    scaleColor: EmVars.colors.textColor
    lineWidth: 15
    size: 150
    barColor: (percent) ->
      "rgb(" + Math.round(200 * percent/100) + ", " + Math.round(200 * (1-percent/100)) + ", 0)"

  #setting interval for demo purposes only. this is not meant for production!
  setInterval ->
    $(".easy-pie-chart-percent").each ->
      val = EmVars.rand(0,80)
      $(@).data("easyPieChart").update(val)
      $(@).find("span").text("#{val}%")
  , 2500