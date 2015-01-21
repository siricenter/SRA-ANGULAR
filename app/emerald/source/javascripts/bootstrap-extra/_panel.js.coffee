class window.PanelView extends View
  @StoreKey = "PanelData"

  ui:
    close: '.panel-actions .panel-close'
    collapse: '.panel-actions .panel-collapse'
    collapseIcon: '.panel-actions .panel-collapse i'
    fullscreen: '.panel-actions .panel-fullscreen'
    fullscreenIcon: '.panel-actions .panel-fullscreen i'
    color: '.panel-actions .panel-color'
    colorSelect: '.panel-actions .panel-color select[rel=colorselector]'
    colorSelected: '.panel-actions .panel-color select[rel=colorselector] option:checked'
    colorize: '.panel-colorize'
    classify: '.panel-actions .panel-classify'
    classifySelect: '.panel-actions .panel-classify select[rel=classselector]'
    refresh: '.panel-actions .panel-refresh'
    refreshIcon: '.panel-actions .panel-refresh i'
    title: '.panel-title'
    titleEditable: '.panel-title .panel-title-edtitable'
    bodyCollapse: '.panel-body-collapse'
    body: '.panel-body'

  events:
    'click @ui.close': 'toggleClose'
    'click @ui.collapse': 'toggleCollapse'
    'click @ui.fullscreen': 'toggleFullscreen'
    'change @ui.colorSelect': 'changeColor'
    'change @ui.classifySelect': 'changeClass'
    'click @ui.refresh': 'refresh'

  constructor: ->
    super

    # events hash doesn't work ...
    @ui.titleEditable.editable(url: ->)
    @ui.titleEditable.on('save', @saveTitle)

    # setup id
    @id = @$el.attr('id')
    if !@id?
      @id = BSE.Utils.Id.rid()
      @$el.attr('id', @id)

    # set the colorselector value to the @ui.colorize bg
    if @ui.color.length && @ui.colorize.length
      color = @ui.colorize.css('background-color')
      @ui.colorSelect.colorselector('setValue', color)
      
    # setup the classselector, et value to the @el class
    if @ui.classify.length && @ui.classifySelect.length
      @classifyClasses = @ui.classifySelect.find('option').map -> $(@).val()
      @existingClass = _.find @classifyClasses, (c) => @$el.hasClass(c)
      if @existingClass
        @ui.classifySelect.classselector('setValue', @existingClass)

    # setup data
    _.values(@events)
    @dataAttrs = ['close', 'collapse', 'fullscreen', 'title', 'url']
    @attrData = _.pick @$el.data(), @dataAttrs...
    @storeData = store.get("#{PanelView.StoreKey}/#{@id}")
    data = if @storeData? then @storeData else @attrData
    @data = {}

    # unravel state as in data
    @close() if data.close
    if data.collapse then @collapse() else @uncollapse()
    @fullscreen() if data.fullscreen
    @title(data.title) if data.title
    @color(data.color) if data.color
    @klass(data.klass) if data.klass
    @body(@attrData.url) if @attrData.url

  saveData: ->
    store.set("#{PanelView.StoreKey}/#{@id}", @data)

  toggleClose: (e, params) =>
    if @data.close
      @data.close = false
      # nothing to do
      @saveData()
    else
      text = "Are you sure you want to close this panel?"
      if BootstrapDialog
        BootstrapDialog.confirm text, (reply) =>
          @close() if reply
      else if confirm(text)
        @close()

  close: ->
    @data.close = true
    @$el.remove()
    @saveData()

  toggleCollapse: (e, params) =>
    if @data.collapse then @uncollapse() else @collapse()

  uncollapse: ->
    @data.collapse = false
    @ui.bodyCollapse.collapse(toggle: false)
    @ui.bodyCollapse.collapse('show')
    @saveData()
    @ui.collapseIcon.removeClass('fa-plus')
    @ui.collapseIcon.addClass('fa-minus')

  collapse: ->
    @data.collapse = true
    @ui.bodyCollapse.collapse(toggle: false)
    @ui.bodyCollapse.collapse('hide')
    @saveData()
    @ui.collapseIcon.removeClass('fa-minus')
    @ui.collapseIcon.addClass('fa-plus')

  toggleFullscreen: (e, params) =>
    if @data.fullscreen
      @data.fullscreen = false
      @$el.removeClass('fullscreen')
      @saveData()
      @ui.fullscreenIcon.removeClass('fa-compress')
      @ui.fullscreenIcon.addClass('fa-expand')
    else
      @fullscreen()

  fullscreen: =>
    @data.fullscreen = true
    @$el.addClass('fullscreen')
    @saveData()
    @ui.fullscreenIcon.removeClass('fa-expand')
    @ui.fullscreenIcon.addClass('fa-compress')

  changeColor: (e, params) =>
    color = @$(@_uiBindings.colorSelected).data('color')
    @_color(color)

  color: (color) ->
    @_color(color)
    @ui.colorSelect.colorselector('setColor', color)

  changeClass: (e, params) =>
    klazz = @$(@_uiBindings.classifySelect).val()
    @_klass(klazz)

  klass: (klazz) ->
    @_klass(klazz)
    @ui.classifySelect.classselector('setValue', klazz)

  _klass: (klazz) ->
    @_swapClass(klazz)
    @data.klass = klazz
    @saveData()
    
  _swapClass: (klazz) =>
    _.each @classifyClasses, (c) => @$el.removeClass(c)
    @$el.addClass(klazz)

  refresh: (e, params) =>
    @body(@attrData.url) if @attrData.url

  saveTitle: (e, params) =>
    @title(params.newValue)

  title: (t) =>
    @ui.titleEditable.html(t)
    @data.title = t
    @saveData()

  body: (url) =>
    xhr = $.get(url)
    @ui.refreshIcon.addClass('faa-spin')
    xhr.done (data) =>
      @ui.body.html(data)
      cb = => @ui.refreshIcon.removeClass('faa-spin')
      setTimeout cb, 350


class window.PanelsView extends View
  @StoreKey = "PanelData"

  ui:
    panels: '.panels'
    panel: '.panel'
    handle: '.panel-handle'
    actions: '.panel-actions'

  events:
    'sortupdate @ui.panels': 'sortupdate'

  constructor: ->
    super
    @ui.panels.sortable
      connectWith: @_uiBindings.panels,
      items: @_uiBindings.panel
      handle: @_uiBindings.handle
      cancel: @_uiBindings.actions
      forceHelperSize: true
      placeholder: "ui-sortable-placeholder panel panel-placeholder"
      forcePlaceholderSize: true
      revert: true
      tolerance: "pointer"
      iframeFix: false
      opacity: 0.8
      helper: 'original'
      stop: (e, ui) -> $(ui.item).css('zIndex', '');
    @ui.panels.each (i, el) =>
      $el = $(el)
      id = $el.attr('id')
      order = store.get("#{PanelsView.StoreKey}/#{id}")
      @sortPanels($el, order) if order?
    @ui.panel.each (i, el) =>
      $el = $(el)
      new PanelView(el: $el)

  sortPanels: ($parent, order) =>
    _.each order, (id) =>
      $el = @$("##{id}")
      $el.appendTo($parent)

  sortupdate: (e, ui) ->
    @ui.panels.each (i, el) =>
      $el = $(el)
      id = $el.attr('id')
      collection = $el.find(@_uiBindings.panel).map(-> @id).get()
      store.set("#{PanelsView.StoreKey}/#{id}", collection)


$.fn.panels = ->
  @each -> new PanelsView(el: @)
