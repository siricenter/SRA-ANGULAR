#use sparklineResponsive like you would use sparklines normally, to add a window resize call to resize the charts when the window does

$.fn.extend
  sparklineResponsive: (data, options) ->
    return @each () ->
      $el = $(this)
      $el.sparkline data, options
      sparkResize = null
      $(window).on 'resize', ->
        clearTimeout sparkResize
        sparkResize = setTimeout ->
          $el.sparkline data, options
        , 500