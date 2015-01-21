$(document).on 'ready page:load', ->

  data = []
  totalPoints = 300
  updateInterval = 30

  getRandomData = ->
    data = data.slice(1)  if data.length > 0

    while data.length < totalPoints
      prev = (if data.length > 0 then data[data.length - 1] else 50)
      y = prev + Math.random() * 10 - 5
      if y < 0
        y = 0
      else y = 100  if y > 100
      data.push y

    res = []
    i = 0

    while i < data.length
      res.push [i, data[i]]
      ++i
    res

  update = ->
    live.setData [getRandomData()]
    live.draw()
    setTimeout update, updateInterval
    return

  $(".flot-live").length and (live = $.plot(".flot-live", [getRandomData()],
    series:
      lines:
        show: true
        lineWidth: 1
        fill: true
        fillColor:
          colors: [
            { opacity: 0.2 }
            { opacity: 0.1 }
          ]

      shadowSize: 2

    colors: [EmVars.colorFromName('light-dk')]
    yaxis:
      min: 0
      max: 100

    xaxis:
      show: false

    grid:
      tickColor: EmVars.colors.light.color
      borderWidth: 0
  )) and update()
