$(document).on 'ready page:load', ->
  $('.table-checkable').on 'ifChecked', -> $(this).closest('table').find('.table-checkable-row').iCheck('check')
  $('.table-checkable').on 'ifUnchecked', -> $(this).closest('table').find('.table-checkable-row').iCheck('uncheck')