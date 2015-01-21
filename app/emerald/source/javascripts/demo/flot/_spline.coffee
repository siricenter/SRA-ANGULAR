$(document).on 'ready page:load', ->

  #random data generator. see flot docs for the format
  randomData = -> _.map([0..15], (i) -> [i, parseInt((Math.floor(Math.random() * (1 + 30 - 10))) + 10)])

  $('.flot-spline').each ->

    $.plot($(@), [
      randomData()
      randomData()
    ],
      series:
        lines:
          show: false

        splines:
          show: true
          tension: 0.4
          lineWidth: 1
          fill: 0.4

        points:
          radius: 0
          show: true

        shadowSize: 2

      grid:
        hoverable: true
        clickable: true
        tickColor: EmVars.colors.light.color
        borderWidth: 1
        color: EmVars.colors.light.color

      colors: [
        EmVars.colors.success.color
        EmVars.colors.primary.color
      ]
      xaxis: {}
      yaxis:
        ticks: 4

      tooltip: true
      tooltipOpts:
        content: "%x.1 = %y.4"
        defaultTheme: false
        shifts:
          x: 0
          y: 20
    )
