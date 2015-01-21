$(document).on 'ready page:load', ->
  $('#reset-localstorage').on 'click', ->
    text = "Are you sure you want to reset all widgets state?"
    if BootstrapDialog
      BootstrapDialog.confirm text, (reply) =>
        if reply
          store.clear()
          Turbolinks.visit(location.pathname)
    else if confirm(text)
        store.clear()
        Turbolinks.visit(location.pathname)