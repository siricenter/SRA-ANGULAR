$(document).on 'ready page:load', ->

  #random data generator. see flot docs for the format
  randomData = -> _.map([1..6], (i) -> [i, parseInt((Math.floor(Math.random() * (1 + 30 - 10))) + 10)])

  $('.flot-multi').each ->

    $.plot($(@), [
      { data: randomData(), label: "Unique Visits" }
      { data: randomData(), label: "Page Views" }
    ],
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
          show: true

        shadowSize: 2

      grid:
        hoverable: true
        clickable: true
        tickColor: EmVars.colors.light.color
        borderWidth: 0

      colors: [
        EmVars.colors.success.color
        EmVars.colors.primary.color
      ]
      xaxis:
        ticks: 15
        tickDecimals: 0

      yaxis:
        ticks: 10
        tickDecimals: 0

      tooltip: true
      tooltipOpts:
        content: "'%s' of %x.1 is %y.4"
        defaultTheme: false
        shifts:
          x: 0
          y: 20
    )
