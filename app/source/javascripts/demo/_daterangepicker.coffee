$(document).on 'ready page:load', ->

  $els = $('.reportrange')

  $els.each ->
    $el = $(this)
    $elSpan = $el.find('span')
    format = 'MMMM D'



    $el.daterangepicker
      startDate: moment().subtract('days', 29)
      endDate: moment()
      minDate: '01/01/2014'
      maxDate: '12/31/2014'
      dateLimit: days: 60
      timePicker: false
      timePickerIncrement: 1
      timePicker12Hour: true
      ranges:
        Today:         [moment(), moment()]
        Yesterday:     [moment().subtract('days', 1), moment().subtract('days', 1)]
        'Last 7 Days': [moment().subtract('days', 6), moment()]
        'This Month':  [moment().startOf('month'), moment().endOf('month')]
        'Last Month':  [moment().subtract('month', 1).startOf('month'), moment().subtract('month', 1).endOf('month')]

      opens: 'left'
      buttonClasses: ['btn-sm']
      applyClass: 'btn btn-success'
      cancelClass: 'btn btn-default'
      format: 'MM/DD/YYYY'
      separator: ' to '
      locale:
        fromLabel: 'From'
        toLabel: 'To'
        customRangeLabel: 'Custom Range'
        daysOfWeek: EmVars.helpers.abbrDays
        monthNames: EmVars.helpers.monthNames
        firstDay: 1
    , (start, end) ->
      $elSpan.html start.format(format) + " - " + end.format(format)
      return

    $elSpan.html moment().subtract('days', 29).format(format) + " - " + moment().format(format)