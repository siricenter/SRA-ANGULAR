$(document).on 'ready page:load', ->

  data = _.map [40,10,20,12,18], (n,i) -> { label: EmVars.helpers.words[i], data: n }

  baseColor = EmVars.colors.info.color

  #create an array of 5 colors based on darker versions of the baseColor
  colors = _.map [1..5], (i) -> EmVars.dk(baseColor, 10*i)

  $('.flot-pie-donut').each ->


    $.plot($(@), data,
      series:
        pie:
          innerRadius: 0.4
          show: true
          stroke:
            width: 0

          label:
            show: true
            threshold: 0.05

      colors: colors

      grid:
        hoverable: true
        clickable: false

      tooltip: true
      tooltipOpts:
        content: "%s: %p.0%"
        defaultTheme: false
        shifts:
          x: 0
          y: 20
    )

  $('.flot-pie').each ->

    $.plot($(@), data,
      series:
        pie:
          combine:
            color: EmVars.colors.textColor
            threshold: 0.05

          show: true

      colors: colors
      legend:
        show: false

      grid:
        hoverable: true
        clickable: false

      tooltip: true
      tooltipOpts:
        content: "%s: %p.0%"
        defaultTheme: false
        shifts:
          x: 0
          y: 20
    )