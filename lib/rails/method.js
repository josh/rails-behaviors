(function() {
  $(document).delegate('a[data-method]', 'click', function(event) {
    var element, form, input;
    element = $(this);
    if (element.is('a[data-remote]')) {
      return;
    }
    form = document.createElement('form');
    $(form).attr({
      method: 'post',
      action: element.attr('href'),
      style: 'display:none;'
    });
    input = document.createElement('input');
    $(input).attr({
      type: 'hidden',
      name: '_method',
      value: element.attr('data-method')
    });
    form.appendChild(input);
    document.body.appendChild(form);
    $(form).submit();
    event.preventDefault();
    return false;
  });
}).call(this);
