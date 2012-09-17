(function() {

  $(document).on('click', 'a[data-method]', function(event) {
    var element, form, input, method;
    element = $(this);
    if (element.is('a[data-remote]')) {
      return;
    }
    method = element.attr('data-method').toLowerCase();
    if (method === 'get') {
      return;
    }
    form = document.createElement('form');
    form.method = 'POST';
    form.action = element.attr('href');
    form.style.display = 'none';
    if (method !== 'post') {
      input = document.createElement('input');
      input.setAttribute('type', 'hidden');
      input.setAttribute('name', '_method');
      input.setAttribute('value', method);
      form.appendChild(input);
    }
    document.body.appendChild(form);
    $(form).submit();
    event.preventDefault();
    return false;
  });

}).call(this);
