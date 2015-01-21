$.extend true, $.fn.dataTable.defaults,
  oLanguage:
    sSearch: ''

$.extend $.fn.dataTableExt.oPagination.bootstrap,
  fnInit: (oSettings, nPaging, fnDraw) ->
    oLang = oSettings.oLanguage.oPaginate
    fnClickHandler = (e) ->
      e.preventDefault()
      fnDraw oSettings  if oSettings.oApi._fnPageChange(oSettings, e.data.action)
      return

    $(nPaging).append "<ul class='pagination'>" + "<li class='prev disabled'><a href='#'>" + oLang.sPrevious + "</a></li>" + "<li class='next disabled'><a href='#'>" + oLang.sNext + "</a></li>" + "</ul>"
    els = $("a", nPaging)
    $(els[0]).bind "click.DT",
      action: "previous"
    , fnClickHandler
    $(els[1]).bind "click.DT",
      action: "next"
    , fnClickHandler
    return
