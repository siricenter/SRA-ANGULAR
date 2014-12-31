class window.Switch

  constructor: (input) ->
    if 'checkbox' != input.type
      throw new Error('You can\'t make Switch out of non-checkbox input')
    @input = $(input)
    @input.css(display: 'none')
    @el = $("""
      <div class="ios-switch">
        <div class="on-background background-fill"></div>
        <div class="state-background background-fill"></div>
        <div class="handle"></div>
      <div>
    """)
    @el.insertBefore(@input)
    @turnOn() if @input.is(':checked')

  toggle: ->
    if @el.hasClass('on') then @turnOff() else @turnOn()
    @input.trigger('onchange')
  
  turnOn: ->
    @el.addClass('on')
    @el.removeClass('off')
    @input.prop('checked', true)

  turnOff: ->
    @el.removeClass('on')
    @el.addClass('off')
    @input.prop('checked', false)

