Selectize.define('nano_scroller', function(options) {
  var self = this;
  self.refreshOptions = (function() {
      var original = self.refreshOptions;
      return function() {
          original.apply(self, arguments);
          self.$nano = $('<div class="nano"></div>');
          self.$nano_content = $('<div class="nano-content"></div>');
          self.$nano.append(self.$nano_content);
          self.$nano_content.append(self.$dropdown_content.html());
          self.$dropdown_content.empty();
          self.$dropdown_content.append(self.$nano);
          self.$nano.height(400);
          self.$nano.nanoScroller({flash: true, iOSNativeScrolling: true});
      };
  })();
});
