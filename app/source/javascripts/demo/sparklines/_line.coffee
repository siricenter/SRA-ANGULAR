$(document).on 'ready page:load', ->

  el = $('.sparkline-line')
  #random dataset function
  data = -> _.map [1..10], -> EmVars.rand(1,6)

  el.each ->
    $el = $(this)
    height = "100px"
    #set the height from data-height or default to 100px
    height = "#{$el.data('height')}px" if $el.data('height')

    #we use our helper here because we need some window resize tricks for it to be responsive (checkout vendored/responsive_sparklines)
    $el.sparklineResponsive data(),
      type: "line"
      width: "100%"
      height: height
      lineColor: EmVars.colors.white.color
      lineWidth: 2
      fillColor: 'transparent'
      spotColor: EmVars.colors.white.color
      minSpotColor: EmVars.colors.white.color
      maxSpotColor: EmVars.colors.white.color
      highlightLineColor: EmVars.colors.white.color
      highlightSpotColor: EmVars.colors.white.color
      spotRadius: 4
      normalRangeMin: 1
