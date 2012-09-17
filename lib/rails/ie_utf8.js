(function() {
  var m;

  if ((m = navigator.userAgent.match(/MSIE ([\w]+)/)) && parseInt(m[1]) <= 8) {
    $(document).on('submit:prepare', 'form', function() {
      if ($(this).find('input[name=utf8]').length === 0) {
        $(this).prepend('<input type=hidden name=utf8 value=✓>');
      }
    });
  }

}).call(this);
