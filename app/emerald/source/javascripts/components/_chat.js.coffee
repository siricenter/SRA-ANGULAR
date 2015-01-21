class window.ChatView extends View
  
  ui:
    sender: '.chat-sender textarea'
    messages: '.chat-messages .nano-content'
    nano: '.nano'

  events:
    'keyup @ui.sender': 'send'
    
  bubbleTemplate: =>
    return @_bubbleTemplate if @_bubbleTemplate?
    tmpl = _.template $("#chat-bubble-right-template").html()
    @_bubbleTemplate = $.proxy(tmpl, @)
    return @_bubbleTemplate
  
  constructor: ->
    super
    @ui.nano.nanoScroller(scroll: 'bottom')
    
  send: (e) =>
    console.log e.which
    if e.which == 13  # enter key
      @message = @ui.sender.val()
      if @message.length > 0
        @ui.messages.append @bubbleTemplate()(@)
        @ui.nano.nanoScroller() # recompute
        @ui.nano.nanoScroller(scroll: 'bottom')
        @ui.sender.val('')
