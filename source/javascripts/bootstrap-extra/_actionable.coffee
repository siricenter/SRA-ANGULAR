class ActionableView extends View
  ui:
    action: '.actionable-action'
    back: '.actionable-back'
  events:
    'click @ui.action': 'action'
    'click @ui.back': 'back'
  action: ->
    @$el.trigger('acting.actionable')
    @$el.one $.support.transition.end, =>
      @$el.one $.support.transition.end, =>
        @$('.actionable-animated-fadeInLeftSmall').addClass('animated fadeInLeftSmall')
        cb = -> @$('.actionable-animated-fadeInRightSmall').addClass('animated fadeInRightSmall')
        setTimeout cb, 200
        @$el.trigger('acted.actionable')
      @$el.addClass('actioning')
    @$el.addClass('ready')
  back: ->
    @$el.one $.support.transition.end, =>
      @$el.removeClass('ready')
      @$('.actionable-animated-fadeInLeftSmall').removeClass('animated fadeInLeftSmall')
      @$('.actionable-animated-fadeInRightSmall').removeClass('animated fadeInRightSmall')
    @$el.removeClass('actioning')
  
$(document).on 'ready page:load', ->
  $('.actionable').each ->
    $this = $(this)
    new ActionableView(el: $this)
