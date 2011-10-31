(function() {
  $(document).delegate('a[data-remote]', 'click', function(event) {
    var dataType, element, settings, type, url;
    element = $(this);
    settings = {};
    settings.context = this;
    if (type = element.data('method')) {
      settings.type = type;
    }
    if (url = element.attr('href')) {
      settings.url = url;
    }
    if (dataType = element.data('type')) {
      settings.dataType = dataType;
    }
    $.ajax(settings);
    event.preventDefault();
    return false;
  });
  $(document).delegate('form[data-remote]', 'submit', function(event) {
    var data, dataType, form, settings, type, url;
    form = $(this);
    settings = {};
    settings.context = this;
    if (type = form.attr('method')) {
      settings.type = type;
    }
    if (url = form.attr('action')) {
      settings.url = url;
    }
    if (data = form.serializeArray()) {
      settings.data = data;
    }
    if (dataType = form.data('type')) {
      settings.dataType = dataType;
    }
    $.ajax(settings);
    event.preventDefault();
    return false;
  });
}).call(this);
