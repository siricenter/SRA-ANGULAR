EVENTS = [
  {
    title: "All Day Event"
    start: "2014-06-01"
    className: 'bg-primary-lt'
  }
  {
    title: "Another All Day Event"
    start: "2014-06-02"
    className: 'bg-primary-lt'
  }
  {
    title: "Long Event"
    start: "2014-06-07"
    end: "2014-06-10"
    className: 'bg-info-dk'
  }
  {
    id: 999
    title: "Repeating Event"
    start: "2014-06-09T16:00:00"
    className: 'bg-success'
  }
  {
    id: 999
    title: "Repeating Event"
    start: "2014-06-16T16:00:00"
    className: 'bg-warning'
  }
  {
    title: "Meeting"
    start: "2014-06-12T10:30:00"
    end: "2014-06-12T12:30:00"
    className: 'bg-danger'
  }
  {
    title: "Lunch"
    start: "2014-06-12T12:00:00"
    className: 'bg-primary-lt'
  }
  {
    title: "Birthday Party"
    start: "2014-06-13T07:00:00"
    className: 'bg-primary-lt'
  }
  {
    title: "Click for Google"
    url: "http://google.com/"
    start: "2014-06-28"
    className: 'bg-light'
  }
  {
    title: "Extra event"
    url: "http://google.com/"
    start: "2014-06-29"
    className: 'bg-primary-lt'
  }
]

$(document).on 'ready page:load', ->
  $('[rel=fullcalendar]').each ->
    $this = $(this)
    $this.fullCalendar
      header:
        left: "prev,next today"
        center: "title"
        right: "month,agendaWeek,agendaDay"
      events: EVENTS
      defaultDate: "2014-06-12"
      editable: true,
      dragOpacity: "0.5"
      selectable: true
      selectHelper: true
      select: (start, end, jsEvent, view) ->
        event =
          title: "New event"
          start: start
          end: end
        $this.fullCalendar 'renderEvent', event, true
      eventClick: (calEvent, jsEvent, view) ->
        $modal = $('#modal')
        kind = calEvent.className[0].match(/^bg-(.*)$/)[1]
        modalClass = 'modal-' + kind
        $modal.addClass(modalClass)
        $modal.find('.modal-title').html(calEvent.title)
        $modal.modal('show')
        $modal.one 'hidden.bs.modal', -> $modal.removeClass(modalClass)
        