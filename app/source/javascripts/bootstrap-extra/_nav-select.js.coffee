$.fn.navSelect = ->
  @each ->
    $this = $(this)
    $inactive = $this.find('> li:not(.active)')
    $activeLink = $this.find('> li.active > a')
    $inactive.addClass('hidden-xs')
    $activeLink.on 'click.bse.navSelect', (e) ->
      if BSE.Utils.Mq.screen() == 'xs'
        $inactive.toggleClass('hidden-xs')
        e.preventDefault()
        $activeLink.off 'click.bse.navSelect'