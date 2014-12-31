class ListFilter
  @DEFAULTS =
    filter: true

  constructor: (element, @options, @val) ->
    @$element = $(element)
    @$collapse = @$element.find('.collapse')
    @reseting = false
    $that = this
    @submenus = []
    @$collapse.on 'show.bs.collapse', ->
      $this = $(this)
      $that.submenus.push($this)
      $that.filter($that.val, $this)

  reset: ->
    @reseting = true
    @val = ''
    @filter('')
    _.each @submenus, ($submenu) =>
      @filter('', $submenu)
    @submenus = []
    @reseting = false

  filter: (val, $element = @$element) =>
    @val = val if val?
    $children = $element.find(' > *')
    if @val == ''
      $children.show()
      @reset() unless @reseting
      return
    $descendants = $element.find('*')
    $found = $descendants.filter("*:containsi(#{@val})")
    $view = $children.filter $found.parents()
    $hide = $children.not $view
    $view.show()
    $hide.hide()


old = $.fn.listFilter

$.fn.listFilter = (option, val) ->
  @each ->
    $this = $(@)
    data = $this.data("bse.listfilter")
    options = $.extend(ListFilter.DEFAULTS, $this.data(), typeof option == 'object' && option)
    $this.data("bse.listfilter", (data = new ListFilter(this, options, val))) if !data
    data[option](val) if typeof option == 'string'

$.fn.listFilter.Constructor = ListFilter

$.fn.listFilter.noConflict = ->
  $.fn.listFilter = old
  return this

run = (e) ->
  $this = $(this)
  target = $this.attr('data-target') || e?.preventDefault?()
  $target = $(target)
  data = $target.data("bse.listfilter")
  option = if data then 'filter' else $this.data()
  $target.listFilter(option, $this.val())

$(document).on 'keyup.bse.listfilter.data-api', '[data-toggle=listfilter]', -> $(@).change()
$(document).on 'change.bse.listfilter.data-api', '[data-toggle=listfilter]', run
