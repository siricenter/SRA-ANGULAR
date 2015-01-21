$(document).on 'ready page:load', ->
  $('[data-growl]').on 'click', ->
    $el = $(this)

    dataProperties = ['title', 'message', 'namespace', 'duration', 'close', 'location', 'style', 'size']

    sentDataProperties = _.select dataProperties, (prop) -> $el.data("growl-#{prop}")?
    arrayDataProperties = _.map sentDataProperties, (prop) -> [prop, $el.data("growl-#{prop}")]
    options = _.object arrayDataProperties

    options.title ||= 'Notification'

    if $el.data('growl') == 'default'
      $.growl options
    else
      $.growl[$el.data('growl')] options