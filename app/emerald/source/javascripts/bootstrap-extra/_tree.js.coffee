$.fn.tree = ->
  @each ->
    $(this).find('li:has(ul)').addClass('tree-parent').find(' > span').on 'click', (e) ->
      $this = $(this)
      $children = $this.parent('li.tree-parent').find(' > ul > li')
      if $children.is(':visible')
        $children.hide('fast')
        $this.find(' > i').addClass('fa-plus').removeClass('fa-minus')
      else
        $children.show('fast')
        $this.find(' > i').addClass('fa-minus').removeClass('fa-plus')
      e.stopPropagation()
