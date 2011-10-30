(function() {
  $(document).delegate('form', 'submit', function() {
    var button, input, value, _i, _j, _len, _len2, _ref, _ref2;
    _ref = $(this).find('input[type=submit][data-disable-with]');
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      input = _ref[_i];
      input = $(input);
      input.attr('data-enable-with', input.val() || 'Submit');
      if (value = input.attr('data-disable-with')) {
        input.val(value);
      }
      input.prop('disabled', true);
    }
    _ref2 = $(this).find('button[type=submit][data-disable-with]');
    for (_j = 0, _len2 = _ref2.length; _j < _len2; _j++) {
      button = _ref2[_j];
      button = $(button);
      button.attr('data-enable-with', button.text() || '');
      if (value = button.attr('data-disable-with')) {
        button.text(value);
      }
      button.prop('disabled', true);
    }
  });
  $(document).delegate('form', 'ajaxComplete', function() {
    var button, input, _i, _j, _len, _len2, _ref, _ref2;
    _ref = $(this).find('input[type=submit][data-enable-with]');
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      input = _ref[_i];
      input = $(input);
      input.val(input.attr('data-enable-with'));
      input.prop('disabled', false);
    }
    _ref2 = $(this).find('button[type=submit][data-enable-with]');
    for (_j = 0, _len2 = _ref2.length; _j < _len2; _j++) {
      button = _ref2[_j];
      button = $(button);
      button.text(button.attr('data-enable-with'));
      button.prop('disabled', false);
    }
  });
}).call(this);
