Mq = BSE.Utils.Mq

class OffCanvas
  @StoreKey = "PanelData"
  
  SCREENS: _.toArray Mq.screens
  STATES: ['open', 'partial', 'hidden']
  
  constructor: (element, options) ->
    @$element      = $(element)
    @options       = options
    
    @$element = $(@options.element) if (@options.element)
    @$parent = $(@options.parent) if (@options.parent)
    @sibling = @options.sibling if (@options.sibling)
    @control = @options.control
    @persist = @options.persist.split(',') if @options.persist

    @states = {}
    _.each @SCREENS, (screen) =>
      @states[screen] = 'hidden' # default
      _.each @STATES, (state) =>
        clazz = "oc-#{screen}-#{state}-#{@control}"
        @states[screen] = state if @$element.hasClass(clazz)

    if @options.toggle && @options.states
      @toggle(@options.states.split(','))
    else
      @setStateFromStore()
    @closeOpenInner(Mq.screen()) if @states[Mq.screen()] == 'partial'
  
  hideSiblings: (screens...) ->
    if @sibling? && @$parent?
      classes = _.map screens, (screen) => ".oc-#{screen}-open-#{@sibling}"
      $actives = @$parent.find(classes.join(', '))
      if $actives && $actives.length
        $actives.offcanvas('setState', @sibling, 'hidden', screens)
        
  closeOpenInner: (screens...) ->
    $sides = @$parent.find('.oc-sidebar')
    $sides.find(".oc-sidebar-nav > li").removeClass('active')
    $sides.find(".oc-sidebar-nav > li > a").addClass('collapsed')
    $sides.find(".collapse.in").removeClass('in')

  setStateFromStore: ->
    if @persist? && _.isArray(@persist)
      states = store.get("#{OffCanvas.StoreKey}/#{@control}/#{@$element.attr('id')}")
      if states?
        states = _.objFilter states, (state, screen) => screen in @persist
        _.each states, (state, screen) => @_setStateForScreen(state, screen)
        @$element.trigger('statechange.bse.offcanvas')

  setState: (state, screens...) ->
    _.each screens, (screen) => @_setStateForScreen(state, screen)
    @$element.trigger('statechange.bse.offcanvas')
    store.set("#{OffCanvas.StoreKey}/#{@control}/#{@$element.attr('id')}", @states)

  toggle: (states = @STATES) ->
    i = states.indexOf(@states[Mq.screen()])
    nextState = if i in [-1, states.length-1] then states[0] else states[i+1]
    @setState(nextState, Mq.screen())

  _setStateForScreen: (state, screen) ->
    @$element.removeClass("oc-#{screen}-#{@states[screen]}-#{@control}")
    @$element.addClass("oc-#{screen}-#{state}-#{@control}")
    @states[screen] = state
    @hideSiblings(screen) if state == 'open'
    if state == 'partial' && screen == Mq.screen()
      @closeOpenInner(screen)


old = $.fn.offcanvas

$.fn.offcanvas = (option, control, args...) ->
  @each ->
    $this = $(@)
    control ?= (typeof option == 'object' && option.control) || 'left'
    data = $this.data("bse.offcanvas.#{control}")
    options = $.extend({}, $this.data(), typeof option == 'object' && option)
    $this.data("bse.offcanvas.#{control}", (data = new OffCanvas(this, options))) if !data
    data[option](args...) if typeof option == 'string'

$.fn.offcanvas.Constructor = OffCanvas

$.fn.offcanvas.noConflict = ->
  $.fn.offcanvas = old
  return this

init = (e) ->
  $this = $(this)
  target = $this.attr('data-target') || e?.preventDefault?() || 
    (href = $this.attr('href')) && href.replace(/.*(?=#[^\s]+$)/, '') #strip for ie7
  control = $this.data('control') || 'left'
  states = $this.data('states')
  states = states.split(',') if states?
  $target = $(target)
  data = $target.data("bse.offcanvas.#{control}")
  option = if data? then 'toggle' else $this.data()
  $target.offcanvas(option, control, states)

$(document).on 'click.bse.offcanvas.data-api', '[data-toggle=offcanvas]', init
