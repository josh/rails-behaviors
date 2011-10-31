(function() {
  $(document).bind('ajaxBeforeSend', function(event, xhr, settings) {
    var token;
    if (settings.crossDomain) {
      return;
    }
    if (token = $('meta[name="csrf-token"]').attr('content')) {
      xhr.setRequestHeader('X-CSRF-Token', token);
    }
  });
  $(document).delegate('form', 'submit', function(event) {
    var form, param, token;
    form = $(this);
    if (form.is('form[data-remote]')) {
      return;
    }
    param = $('meta[name="csrf-param"]').attr('content');
    token = $('meta[name="csrf-token"]').attr('content');
    if ((param != null) && (token != null)) {
      if (!form.find("input[name=" + param + "]")[0]) {
        form.prepend("<input type='hidden' name='" + param + "' value='" + token + "'>");
      }
    }
  });
}).call(this);
