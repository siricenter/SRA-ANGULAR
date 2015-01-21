/**
 selectize input.
 **/

"use strict";

var Constructor = function(options) {
  this.init('selectize', options, Constructor.defaults);
  options.selectize = options.selectize || {};
  this.prerender();
  this.render();
};

$.fn.editableutils.inherit(Constructor, $.fn.editabletypes.abstractinput);

$.extend(Constructor.prototype, {
  render: function() {
    this.setClass();
    //trigger resize of editableform to re-position container in multi-valued mode
    if (this.isMultiple) {
      this.$input.on('change', function() {
        $(this).closest('form').parent().triggerHandler('resize');
      });
    }
    this.$input.selectize(this.options.selectize);
  },
  value2html: function(value, element) {
    var val;
    var delimiter = this.getDelimiter();
    var options = value.split(delimiter);
    var selectize = this.$input.data('selectize');
    var results = [];
    for (var i = 0; i < options.length; i++) {
      results.push(selectize.getItem(options[i]).html());
    }
    val = results.join(delimiter);
    Constructor.superclass.value2html.call(this, val, element);
  },
  html2value: function(html) {
    var value = $('<div>').html(html).text();
    var val, res;
    var delimiter = this.getDelimiter();
    var options = value.split(delimiter);
    var selectize = this.$input.data('selectize');
    var results = [];
    for (var i = 0; i < options.length; i++) {
      res = _.find(selectize.options, function(v, k){ 
        return v[selectize.settings.labelField] === $.trim(options[i]);
      });
      if (res) {
        results.push(res[selectize.settings.valueField]);
      }
    }
    val = results.join(delimiter);
    selectize.refreshItems()
    return val;
  },
  value2input: function(value) {
    var delimiter = this.getDelimiter();
    var valueArray = value.split(delimiter);
    this.$input.val(value);
    this.$input.selectize(this.options.selectize);
    this.$input.data('selectize').setValue(valueArray);
  },
  input2value: function() {
    return this.$input.val();
  },
  str2value: function(str, delimiter) {
    if (typeof str !== 'string' || !this.isMultiple) {
      return str;
    }

    delimiter = delimiter || this.getDelimiter();

    var val, i, l;

    if (str === null || str.length < 1) {
      return null;
    }
    val = str.split(delimiter);
    for (i = 0, l = val.length; i < l; i = i + 1) {
      val[i] = $.trim(val[i]);
    }

    return val;
  },
  autosubmit: function() {
    this.$input.on('change', function(e, isInitial) {
      if (!isInitial) {
        $(this).closest('form').submit();
      }
    });
  },
  getDelimiter: function() {
    return this.options.selectize.delimiter || $.fn.selectize.defaults.delimiter;
  },
  destroy: function() {
    if (this.$input.data('selectize')) {
      this.$input[0].selectize.destroy();
    }
  }

});

Constructor.defaults = $.extend({}, $.fn.editabletypes.abstractinput.defaults, {
  /**
   @property tpl 
   @default <input type="hidden">
   **/
  tpl: '<input type="hidden">',
          
  /**
   Configuration of selectize. [Full list of options](http://ivaynberg.github.com/selectize).
   
   @property selectize 
   @type object
   @default null
   **/
  selectize: null
});

$.fn.editabletypes.selectize = Constructor;
