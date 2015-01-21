# Minimal view thingie to make code a bit more manageable.
# Primarily for internal use, but feel free to use it if you like it.
#
# Usage example:
#
#    class MyView extends View
#      ui:
#        button: '.my-button'
#      events:
#        'click @ui.button': 'doAction'
#      constructor: ->
#        super
#        # do initialization here
#      doAction: ->
#        # do action here
#
class window.View

  @delegateEventSplitter = /^(\S+)\s*(.*)$/

  @normalizeUIKeys = (hash, ui) ->
    return if typeof(hash) == 'undefined'
    _.each _.keys(hash), (v) ->
      pattern = /@ui.[a-zA-Z_$0-9]*/g;
      if v.match(pattern)
        cb = (r) -> ui[r.slice(4)]
        k = v.replace(pattern, cb)
        hash[k] = hash[v]
        delete hash[v]
    return hash;
  
  constructor: (options) ->
    @$el = $(options.el)
    @bindUIElements()
    @delegateEvents()
    
  $: (selector) ->
    @$el.find(selector)
    
  delegate: (eventName, selector, listener) ->
    @$el.on(eventName + '.delegateEvents', selector, listener)
    
  normalizeUIKeys: (hash) ->
    ui = _.result(@, 'ui')
    uiBindings = _.result(@, '_uiBindings')
    return View.normalizeUIKeys(hash, uiBindings || ui)
    
  delegateEvents: (events) ->
    events = events || @events;
    events = events.call(@) if _.isFunction(events)    
    events = @normalizeUIKeys(events)
    
    return this if !(events || (events = _.result(this, 'events')))
    for key, method of events
      method = @[events[key]] if (!_.isFunction(method))
      continue if (!method)
      match = key.match(View.delegateEventSplitter)
      this.delegate(match[1], match[2], _.bind(method, this))
    return this
  
  bindUIElements: () ->
    return if !@.ui
    
    @_uiBindings = @ui if !@_uiBindings
    bindings = _.result(@, '_uiBindings')
    @ui = {}
    
    _.each _.keys(bindings), (key) =>
      selector = bindings[key]
      @ui[key] = @$(selector)
