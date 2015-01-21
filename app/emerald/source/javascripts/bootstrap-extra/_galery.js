/*
 SuperBox v1.0.0
 by Todd Motto: http://www.toddmotto.com
 Latest version: https://github.com/toddmotto/superbox
 
 Copyright 2013 Todd Motto
 Licensed under the MIT license
 http://www.opensource.org/licenses/mit-license.php
 
 SuperBox, the lightbox reimagined. Fully responsive HTML5 image galleries.
 */
;
(function($) {

  $.fn.SuperBox = function(options) {

    var superbox = $('<div class="superbox-show"></div>');
    var superboximg = $('<img src="" class="superbox-current-img">');
    var superboxclose = $('<div class="superbox-close"></div>');
    var superboxcontent = $('<div class="superbox-list-content"></div>');

    superbox.append(superboximg).append(superboxclose).append(superboxcontent);

    return this.each(function() {
      var $this = $(this);
      var scroller = $this.data('scroller') || 'html, body';
      var $scroller = $(scroller);

      var $superboxList = $('.superbox-list').click(function() {
        var $this = $(this);
        var $content = $this.find('.superbox-list-content');
        superbox.find('.superbox-list-content').replaceWith($content.clone());
        

        var currentimg = $(this).find('.superbox-img');
        var imgData = currentimg.data('img');
        superboximg.attr('src', imgData);

        if ($('.superbox-current-img').css('opacity') == 0) {
          $('.superbox-current-img').animate({opacity: 1});
        }

        if ($(this).next().hasClass('superbox-show')) {
          superbox.toggle();
        } else {
          superbox.insertAfter(this).css('display', 'block');
        }
        
        $superboxList.removeClass('active');
        if(superbox.css('display') == 'none'){
          $this.removeClass('active');
        } else {
          $this.addClass('active');
        }

        var to = superbox.position().top - currentimg.width();
        $scroller.animate({scrollTop: to}, 'medium');

      });

      $('.superbox').on('click', '.superbox-close', function() {
        $('.superbox-current-img').animate({opacity: 0}, 200, function() {
          $superboxList.removeClass('active');
          $('.superbox-show').slideUp();
        });
      });

    });
  };
})(jQuery);