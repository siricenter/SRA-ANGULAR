$(document).on 'ready page:load', ->
  el = $('.sparkline-pie')

  if el.length

    #some colors
    colors = [
      EmVars.colors.light.color
      EmVars.colorFromName('success-lt')
      EmVars.colorFromName('primary-lt')
    ]

    #we use our helper here because we need some window resize tricks for it to be responsive (checkout vendored/responsive_sparklines)
    el.sparklineResponsive [6,3,5],
      type: 'pie',
      width: '100%',
      height: '200px',
      sliceColors: colors,
      offset: 10,
      borderWidth: 0
      tooltipClassname: 'em-sparkline-tooltip'