# close menu dropdowns on oc-partial

# require off-canvas

backdrop = '.dropdown-backdrop'
Mq = BSE.Utils.Mq

getTarget = ($this) ->
  selector = $this.attr('data-target')
  if !selector
    selector = $this.attr('href')
    selector = selector && /#[A-Za-z]/.test(selector) && selector.replace(/.*(?=#[^\s]*$)/, '') #strip for ie7
  $target = selector && $(selector)
  if $target && $target.length then $target else false

clearMenus = (e) ->
  $this = $(e.target)
  menuPartial = ".oc-#{Mq.screen()}-partial-left"
  return unless $this.closest(menuPartial).length
  return if $this.closest(".collapse, .dropdown").length && !e.inner
  toggle = "#{menuPartial} .oc-sidebar-nav [data-toggle=collapse]"
  $(toggle).each ->
    $this = $(@)
    $target = getTarget($this)
    return unless $target
    relatedTarget = { relatedTarget: @ }
    return if !$target.hasClass('in')
    $target.trigger(e = $.Event('hide.bs.collapse', relatedTarget))
    return if e.isDefaultPrevented()
    $this.addClass('collapsed')
    $target.removeClass('in').trigger('hidden.bs.collapse', relatedTarget)

$document = $(document)
$document.on('click.bs.collapse', clearMenus)
$document.on 'mouseenter.bs.collapse', '.oc-sidebar-nav > li > a', (e)->
  $this = $(this)
  $wrapper = $this.closest('.oc-wrapper')
  menuPartial = "oc-#{BSE.Utils.Mq.screen()}-partial-left"
  partial = $wrapper.size && $wrapper.hasClass(menuPartial)
  clearMenus(target: @, inner: true) if partial

