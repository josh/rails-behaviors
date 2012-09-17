(function() {
  var submitSelectors;

  submitSelectors = "form[data-remote] input[type=submit],\nform[data-remote] button[type=submit],\nform[data-remote] button:not([type]),\nform[data-remote-submit] input[type=submit],\nform[data-remote-submit] button[type=submit],\nform[data-remote-submit] button:not([type])";

  $(document).on('click', submitSelectors, function() {
    var defaultValue, form, input, name, submit, value;
    submit = $(this);
    form = submit.closest('form');
    input = form.find('.js-submit-button-value');
    if (name = submit.attr('name')) {
      defaultValue = submit.is('input[type=submit]') ? 'Submit' : '';
      value = submit.val() || defaultValue;
      if (!input[0]) {
        input = document.createElement('input');
        input.setAttribute('type', 'hidden');
        input.setAttribute('name', name);
        input.setAttribute('value', value);
        input.setAttribute('class', 'js-submit-button-value');
        form.prepend(input);
      } else {
        input.attr('name', name);
        input.attr('value', value);
      }
    } else {
      input.remove();
    }
  });

}).call(this);
