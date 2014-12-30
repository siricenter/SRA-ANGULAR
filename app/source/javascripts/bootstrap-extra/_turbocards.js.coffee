class window.TurboView extends View
  ui:
    grid: '.turbo-grid'
    toggle: '.turbo-toggle'

  events:
    'click @ui.toggle': 'toggle'

  hide: (e) ->
    if !Modernizr.cssanimations
      @$content.remove()
      @$placeholder.remove()
      @$card.removeClass('turbo-card-open')
      @ui.grid.removeClass('turbo-grid-open')
      @$placeholder = null
    else
      @$placeholder.one $.support.transition.end, =>
        @$card.removeClass('turbo-card-open')
        @$placeholder.remove()
        @$placeholder = null
      @$content.remove()
      @$placeholder.css(@initialCoords)
      @$placeholder.removeClass('turbo-placeholder-open')
      cb = => @ui.grid.removeClass('turbo-grid-open')
      setTimeout cb, 200
    
  show: (e) ->
    @$card = $(e.currentTarget).closest('.turbo-card')
    @$placeholder = $("""
      <div class="turbo-placeholder">
        <div class="turbo-placeholder-front">
          #{@$card.html()}
        </div>
        <div class="turbo-placeholder-back">
          &nbsp;
        </div>
      </div>
    """)
    if !Modernizr.cssanimations
      @ui.grid.append(@$placeholder)
      @$card.addClass('turbo-card-open')
      @ui.grid.addClass('turbo-grid-open')
      @$placeholder.addClass('turbo-placeholder-open')
      @$content = $("""
        <div class="turbo-content">
          <button type="button" class="close pull-right turbo-toggle margin">&times;</button>
        </div>
      """).load(@$card.data('turbo-url'))
      @$el.append(@$content)
      @$content.addClass('turbo-content-open')
      @$placeholder.trigger('shown.turbocard')
    else
      @$placeholderBack = @$placeholder.find('.turbo-placeholder-back')
      cardPosition = @$card.position()
      @initialCoords = 
        top: cardPosition.top
        left: cardPosition.left - 15,
        width: @$card.width()
        height: @$card.height()
      @$placeholder.css(@initialCoords)
      @ui.grid.append(@$placeholder)
      @$card.addClass('turbo-card-open')
      cb = =>
        @$content = $("""
          <div class="turbo-content">
            <button type="button" class="close pull-right turbo-toggle margin">&times;</button>
          </div>
        """).load(@$card.data('turbo-url'))
        @$placeholder.one $.support.transition.end, =>
          @$el.append(@$content)
          @$placeholder.trigger('shown.turbocard')
        @$placeholderBack.addClass(@$card.data('back-class'))
        @ui.grid.addClass('turbo-grid-open')
        @$placeholder.addClass('turbo-placeholder-open')
        @$content.addClass('turbo-content-open')
        @$placeholder.css(top: 0, left: 0, width: '100%', height: '100%')
      setTimeout cb, 0
    
  toggle: (e) ->
    if @$placeholder then @hide(e) else @show(e)

$.fn.turbogrid = ->
  @each ->
    $this = $(this)
    data = $this.data('turbo')
    if !data
      view = new TurboView(el: $this)
      $this.data('turbo', view)
     
$(document).on 'ready page:load', ->
  $('.turbo-grid-wrap').turbogrid()

