$.fn.datepicker.DPGlobal.headTemplate = '<thead><tr><th class="prev"><i class="fa fa-arrow-left"/></th><th colspan="5" class="datepicker-switch"></th><th class="next"><i class="fa fa-arrow-right"/></th></tr></thead>';
$.fn.datepicker.DPGlobal.template = '<div class="datepicker">'+
  '<div class="datepicker-days">'+
  '<table class=" ">'+
  $.fn.datepicker.DPGlobal.headTemplate+
  '<tbody></tbody>'+
  $.fn.datepicker.DPGlobal.footTemplate+
  '</table>'+
  '</div>'+
  '<div class="datepicker-months">'+
  '<table>'+
  $.fn.datepicker.DPGlobal.headTemplate+
  $.fn.datepicker.DPGlobal.contTemplate+
  $.fn.datepicker.DPGlobal.footTemplate+
  '</table>'+
  '</div>'+
  '<div class="datepicker-years">'+
  '<table>'+
  $.fn.datepicker.DPGlobal.headTemplate+
  $.fn.datepicker.DPGlobal.contTemplate+
  $.fn.datepicker.DPGlobal.footTemplate+
  '</table>'+
  '</div>'+
  '</div>'