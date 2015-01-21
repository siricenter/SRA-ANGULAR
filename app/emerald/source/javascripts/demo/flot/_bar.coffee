$(document).on 'ready page:load', ->

  randomData = (horizontal=false) ->
    #only return 2 datasets if horizontal
    count = if horizontal then 2 else 4

    _.map [1..count], (i) ->
      #count to x, throw data
      index = i*10
      data = parseInt((Math.floor(Math.random() * (1 + 120 - 60))) + 10)
      if horizontal
        return [data,index]
      else
        return [index,data]

  randomBars = (horizontal=false) ->
    _.map [
      EmVars.colors.primary.color
      EmVars.colors.success.color
      EmVars.colors.danger.color
    ], (color, i) ->
      adjustedColor = EmVars.adjustOpacity(color, 0.5)

      {
        label: "Product #{i+1}"
        data: randomData(horizontal)
        color: adjustedColor
        bars:
          horizontal: horizontal
          show: true
          fill: true
          lineWidth: 1
          order: i+1
          fillColor: adjustedColor
      }

  chartOptions =
    xaxis:
      tickLength: 0
    yaxis: {}
    grid:
      hoverable: true
      clickable: false
      borderWidth: 0

    legend:
      labelBoxBorderColor: "none"
      position: "left"

    series:
      shadowSize: 1

    tooltip: true
    tooltipOpts:
      defaultTheme: false

  $('.flot-bar').each -> $.plot $(@), randomBars(), chartOptions
  $(".flot-bar-horizontal").each -> $.plot $(@), randomBars(true), chartOptions