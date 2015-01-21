$(document).on 'ready page:load', ->

  el = $('.sparkline-composite')

  if el.length

    data1 = _.map [1..10], -> EmVars.rand(1,6)
    data2 = _.map [1..10], -> EmVars.rand(1,6)

    el.sparklineResponsive data1,
      type: "line"
      width: "100%"
      height: "200px"
      fillColor: EmVars.adjustOpacity(EmVars.colorFromName('light-dk'), 0.5)
      lineColor: EmVars.colors.white.color
      spotRadius: 4
      valueSpots: data1
      minSpotColor: EmVars.colors.light.color
      maxSpotColor: EmVars.colors.light.color
      highlightSpotColor: EmVars.colors.light.color
      highlightLineColor: EmVars.colorFromName('light-dk')
      normalRangeMin: 0
      tooltipClassname: 'em-sparkline-tooltip'

    el.sparklineResponsive data2,
      type: "line"
      composite: true
      width: "100%"
      fillColor: EmVars.adjustOpacity(EmVars.colors.primary.color, 0.1)
      lineColor: EmVars.colors.white.color
      minSpotColor: EmVars.colors.primary.color
      maxSpotColor: EmVars.colors.primary.color
      highlightSpotColor: EmVars.colors.info.color
      highlightLineColor: EmVars.colorFromName('light-dk')
      spotRadius: 4
      valueSpots: data2
      normalRangeMin: 0
      tooltipClassname: 'em-sparkline-tooltip'
      responsive: true