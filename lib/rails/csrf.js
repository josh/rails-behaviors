(function() {
  var isSameOrigin;

  $(document).on('ajaxBeforeSend', function(event, xhr, settings) {
    var token;
    if (settings.crossDomain) {
      return;
    }
    if (settings.type === 'GET') {
      return;
    }
    if (token = $('meta[name="csrf-token"]').attr('content')) {
      return xhr.setRequestHeader('X-CSRF-Token', token);
    }
  });

  $(document).on('submit:prepare', 'form', function() {
    var form, input, param, token;
    form = $(this);
    if (form.is('form[data-remote]')) {
      return;
    }
    if (!this.method || this.method.toUpperCase() === 'GET') {
      return;
    }
    if (!isSameOrigin(form.attr('action'))) {
      return;
    }
    param = $('meta[name="csrf-param"]').attr('content');
    token = $('meta[name="csrf-token"]').attr('content');
    if ((param != null) && (token != null)) {
      if (!form.find("input[name=" + param + "]")[0]) {
        input = document.createElement('input');
        input.setAttribute('type', 'hidden');
        input.setAttribute('name', param);
        input.setAttribute('value', token);
        form.prepend(input);
      }
    }
  });

  isSameOrigin = function(url) {
    var a, origin;
    a = document.createElement('a');
    a.href = url;
    origin = a.href.split('/', 3).join("/");
    return location.href.indexOf(origin) === 0;
  };

}).call(this);
