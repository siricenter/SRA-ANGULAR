$(document).on 'ready page:load', ->

  #random data generator. see flot docs for the format
  randomData = -> _.map([1..10], (i) -> [i, parseInt((Math.floor(Math.random() * (1 + 20 - 10))) + 10)])

  $('.flot-line').each ->
    $el = $(this)
    #we can take a data-color attribute from the DOM, or default to info, for the line color
    color = EmVars.colorFromName($el.data('color') || 'info')

    $.plot($el, [data: randomData()],
      series:
        lines:
          show: true
          lineWidth: 1
          fill: true
          fillColor:
            colors: [
              { opacity: 0.3 }
              { opacity: 0.3 }
            ]

        points:
          radius: 3
          show: true

        grow:
          active: true
          steps: 50

        shadowSize: 2

      grid:
        hoverable: true
        clickable: true
        tickColor: EmVars.colors.light.color
        borderWidth: 1
        color: EmVars.colors.light.color

      colors: [color]
      xaxis: {}
      yaxis:
        ticks: 5

      tooltip: true
      tooltipOpts:
        content: "chart: %x.1 is %y.4"
        defaultTheme: false
        shifts:
          x: 0
          y: 20
    )
