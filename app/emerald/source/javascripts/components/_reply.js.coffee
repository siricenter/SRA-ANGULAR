class window.ReplyView extends View
  
  ui:
    triggerContainer: '.reply-trigger-container'
    trigger: '.reply-trigger'
    textarea: '.reply-textarea'

  events:
    'click @ui.trigger': 'expand'
    'focus @ui.textarea': 'expand'
    
  expand: (e) =>
    @ui.triggerContainer.addClass('hidden')
    @ui.textarea.summernote(focus: true, height: 200)
