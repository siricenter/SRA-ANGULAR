# monkey patch Collapse to
# 1. hide other collapsed elements on activating a new one,
#    based on declared parent
# 2. in oc-partial dropdowns: skip animation

Collapse = $.fn.collapse.Constructor
Mq = BSE.Utils.Mq

show = Collapse.prototype.show
hide = Collapse.prototype.hide

Collapse.prototype.inOcPartial = ->
  @$element.closest(".oc-#{Mq.screen()}-partial-left").length

Collapse.prototype.hideActives = ->
  actives = @$parent && @$parent.find('> .dropdown > .in').not(@$element)
  if actives?.length
    hasData = actives.data('bs.collapse')
    return if (hasData && hasData.transitioning)
    actives.collapse('hide')
    hasData || actives.data('bs.collapse', null)

Collapse.prototype.show = ->
  if @inOcPartial()
    # skip animation in oc-partial
    dimension = @dimension()
    @$element
      .trigger('show.bs.collapse')
      .addClass('collapse in')[dimension]('auto')
    @$element.trigger('shown.bs.collapse')
  else
    show.apply(this)
  # hide other collapsed elements on activating a new one
  @hideActives()

Collapse.prototype.hide = ->
  if @inOcPartial()
    # skip animation in oc-partial
    dimension = @dimension()
    @$element
      .trigger('hide.bs.collapse')
      .removeClass('in')[dimension](0)
    @$element.trigger('hidden.bs.collapse')
  else
    hide.apply(this)
