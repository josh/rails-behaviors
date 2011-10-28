(function() {
  var submitSelectors;
  submitSelectors = ['form[data-remote] input[type=submit]', 'form[data-remote] button[type=submit]', 'form[data-remote] button:not([type])'];
  $(document).delegate(submitSelectors.join(', '), 'click', function() {
    var defaultValue, form, input, name, submit, value;
    submit = $(this);
    form = submit.closest('form');
    input = form.find('.js-submit-button-value');
    if (name = submit.attr('name')) {
      defaultValue = submit.is('input[type=submit]') ? 'Submit' : '';
      value = submit.val() || defaultValue;
      if (!input[0]) {
        form.prepend("<input class='js-submit-button-value' type='hidden' name='" + name + "' value='" + value + "'>");
      } else {
        input.attr('name', name);
        input.attr('value', value);
      }
    } else {
      input.remove();
    }
  });
}).call(this);
