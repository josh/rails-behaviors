(function() {

  $(document).on('submit:prepare', 'form', function() {
    var button, input, value, _i, _j, _len, _len1, _ref, _ref1;
    _ref = $(this).find('input[type=submit][data-disable-with]');
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      input = _ref[_i];
      input = $(input);
      input.attr('data-enable-with', input.val() || 'Submit');
      if (value = input.attr('data-disable-with')) {
        input.val(value);
      }
      input[0].disabled = true;
    }
    _ref1 = $(this).find('button[type=submit][data-disable-with]');
    for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
      button = _ref1[_j];
      button = $(button);
      button.attr('data-enable-with', button.html() || '');
      if (value = button.attr('data-disable-with')) {
        button.html(value);
      }
      button[0].disabled = true;
    }
  });

  $(document).on('ajaxComplete', 'form', function() {
    var button, input, _i, _j, _len, _len1, _ref, _ref1;
    _ref = $(this).find('input[type=submit][data-enable-with]');
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      input = _ref[_i];
      $(input).val($(input).attr('data-enable-with'));
      input.disabled = false;
    }
    _ref1 = $(this).find('button[type=submit][data-enable-with]');
    for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
      button = _ref1[_j];
      $(button).html($(button).attr('data-enable-with'));
      button.disabled = false;
    }
  });

}).call(this);
