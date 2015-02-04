# This is for the theme demo site, you probably don't need it
# Feel free to use it for inspiration on how to initialize components

$.fn.transition = $.fn.animate if !$.support.transition

protocol = window.location.protocol || document.location.protocol
if 'file:' == protocol
  Turbolinks.visit = (url) -> window.location.href = url

$document = $(document)

scrollCb = -> $(".nano").nanoScroller(flash: true, iOSNativeScrolling: true)

initOffCanvas = (toggle) ->
  $toggle = $(toggle)
  target = $toggle.attr('href')
  $target = $(target)
  data = $toggle.data()
  data.toggle = false
  $target.offcanvas(data)

load = ->
  $('#oc-left-toggle').length && initOffCanvas('#oc-left-toggle')
  $('#oc-right-toggle').length && initOffCanvas('#oc-right-toggle')

  window.EmVars.colors = EmVars.colorsFromSass()
  $('.datepick').datepicker()
  $('.timepick').timepicker()
  $('.datetimepick').datetimepicker()
  $('.daterangepick').daterangepicker()
  $('.superbox').SuperBox()
  $('input.rating[type=number]').rating()
  $('[rel=datepicker]').datepicker()
  $('[rel=jvfloat]').jvFloat()
  $('[rel=autosize]').autosize()
  $('[rel=tabdrop]').tabdrop text: 'More'
  $('[rel=editable]').editable()
  $('[rel=classselector]').classselector()
  $('[rel=panels]').panels()
  # $('[rel=jcrop]').Jcrop()
  $('[rel=tree]').tree()
  $('[rel=summernote]').summernote()
  $('[rel=selectize]').selectize
    plugins: ['remove_button']
    dropdownClass: 'selectize-dropdown animated fadeIn fast'

  $('[rel=selectize-tags]').selectize
    delimiter: ','
    persist: false
    plugins: ['remove_button']
    dropdownClass: 'selectize-dropdown animated fadeIn fast'
    create: (input) ->
      value: input
      text: input

  $icheck = $('[rel=icheck]')
  $icheck.iCheck(
    labelHover: false,
    cursor: true,
    inheritClass: true;
  )
  
  $powerange = $('[rel=powerange]')
  $powerange.each ->
    $this = $(this)
    new Powerange(this, $this.data())

  $('[rel=switch]').each ->
    $this = $(this)
    iswitch = new Switch(this)
    unless $this.attr('readonly') || $this.attr('disabled')
      $(iswitch.el).on 'click', (e) ->
        e.preventDefault()
        iswitch.toggle()

  responsiveHelper = null
  breakpointDefinition = { tablet: 1024, phone: 480 }

  $datatable = $('.datatable')
  $datatable.dataTable(
    sPaginationType: 'bootstrap'
    bAutoWidth: false
    bStateSave: false
    fnPreDrawCallback: ->
      responsiveHelper ?= new ResponsiveDatatablesHelper($datatable, breakpointDefinition)
    fnRowCallback: (nRow) -> responsiveHelper.createExpandIcon (nRow)
    fnDrawCallback: (oSettings) -> responsiveHelper.respond()
    fnInitComplete: ->
      $wrapper = $datatable.closest('.dataTables_wrapper')
      $wrapper.find('select').selectize
        dropdownClass: 'selectize-dropdown animated fadeIn fast'

      $wrapper.find('.dataTables_filter input').addClass('form-control').attr('placeholder', 'Search')
  )

  $floathead = $('table[rel=floathead]')
  $floathead.floatThead(
    scrollContainer: ($tbl) -> $tbl.closest($tbl.data('scroll'))
    useAbsolutePositioning: false
  )

  $('#oc-wrapper').on 'statechange.bse.offcanvas', ->
    cb = ->
      $(window).trigger('resize')
      $floathead.floatThead('reflow')
    setTimeout(cb, 360) # after animation ends
  
  $container = $('#main-oc-container')
  $sidebarLeft = $('#main-oc-sidebar-left')
  equalize = ->
    sidebarHeight = $sidebarLeft.outerHeight(true)
    containerHeight = $container.outerHeight(true)
    if sidebarHeight > containerHeight
      $container.css(height: sidebarHeight)
    else
      $container.css(height: 'auto')
  equalize()
  $sidebarLeft.find('.collapse').on 'shown.bs.collapse hidden.bs.collapse', equalize

  $('textarea[data-provide=markdown]').each ->
    $this = $(this)
    if $this.data('markdown')
      $this.data('markdown').showEditor()
      return
    $this.markdown($this.data())
    
  $('.nestable').nestable(
    group: 'nestable'
    containerSelector: '.dd-list'
    itemSelector: '.dd-item'
    handle: '.dd-handle'
    afterMove: (placeholder, container) ->
      if oldContainer != container
        if oldContainer
          oldContainer.el.removeClass("active")
        container.el.addClass("active")
        oldContainer = container
    onDrop: (item, container, _super) ->
      container.el.removeClass("active")
      _super(item)
  )

  $('.nav-select').navSelect()

  $('a[href=#]').attr('data-no-turbolink', true)

  scrollCb()

  $('.current-month').text moment().format('MMMM')
  $('.current-day').text moment().format('DD')

  # sparklines that sit inside a carousel are not visible don't know the width of it
  $('[data-ride=carousel]').on 'slide.bs.carousel', ->
    setTimeout ->
      $.sparkline_display_visible()
    , 1
  
  $tooltips = $('[data-tooltip-show]')
  $tooltips.tooltip(trigger: 'manual').tooltip("show")
    
  $popovers = $('[rel="popover-click"]')
  $popovers.popover(
    html: true
    content: -> $('#bigdrop').html()
    template: """
      <div class="popover popover-menu popover-grow-shrink" role="tooltip">
        <div class="arrow"></div>
        <h3 class="popover-title"></h3>
        <div class="popover-content no-padding"></div>
      </div>
    """
  )
  $popovers.on 'shown.bs.popover', ->
    $picheck = $('.popover-menu [rel=icheck]')
    $picheck.iCheck(
      labelHover: false,
      cursor: true,
      inheritClass: true;
    )
  
$ ->
  FastClick.attach(document.documentElement)
  load()

$document.on "shown.bs.modal", ->
  $('.modal-blur-content').css(polyfilter: 'blur(3px)')
$document.on "hidden.bs.modal", ->
  $('.modal-blur-content').css(polyfilter: 'none')

$document.on "page:load", ->
  Dropzone._autoDiscoverFunction()

  #fix for turbolinks and carousel init
  $('[data-ride="carousel"]').each ->
    $carousel = $(this)
    $carousel.carousel $carousel.data()

  load()

$document.on 'page:fetch', -> NProgress.start()
$document.on 'page:change', -> NProgress.done()
$document.on 'page:restore', -> NProgress.remove()

$(window).resize scrollCb
$document.on 'shown.bs.tab', scrollCb
$document.on 'shown.bs.tab', -> $(window).trigger('resize')

# speed up sparklines in tabs
$document.on 'shown.bs.tab', (e) ->
  cb = -> $.sparkline_display_visible()
  setTimeout cb, 1

$document.tooltip(selector: '[rel=tooltip]')
$document.popover(selector: '[rel="popover-sidebar"]', trigger: 'hover', delay: { show: 400, hide: 0 })
$document.popover(selector: '[rel=popover]', trigger: 'hover')
$document.on 'click', (e) ->
  $target = $(e.target)
  if $target.data('toggle') != 'popover' && 
     $target.parents('[data-toggle="popover"]').length == 0 &&
     $target.parents('.popover.in').length == 0
    $('[data-toggle="popover"]').popover('hide')

$document.on 'click', '#oc-open-chat', (e) ->
  $('#oc-right-toggle').tooltip('show')
  $('.oc-scroll').animate({ scrollTop: 0 }, "slow")

$document.on 'shown.turbocard', '.turbo-placeholder', (e) ->
  $('.oc-scroll').animate({ scrollTop: 0 }, "slow")
