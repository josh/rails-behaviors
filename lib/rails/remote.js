(function() {

  $(document).on('click', 'a[data-remote]', function(event) {
    var dataType, element, settings, type, url;
    element = $(this);
    settings = {};
    settings.context = this;
    if (type = element.attr('data-method')) {
      settings.type = type;
    }
    if (url = this.href) {
      settings.url = url;
    }
    if (dataType = element.attr('data-type')) {
      settings.dataType = dataType;
    }
    $.ajax(settings);
    event.preventDefault();
    return false;
  });

  $(document).on('submit', 'form[data-remote]', function(event) {
    var data, dataType, form, settings, type, url;
    form = $(this);
    settings = {};
    settings.context = this;
    if (type = this.method) {
      settings.type = type;
    }
    if (url = this.action) {
      settings.url = url;
    }
    if (data = form.serializeArray()) {
      settings.data = data;
    }
    if (dataType = form.attr('data-type')) {
      settings.dataType = dataType;
    }
    $.ajax(settings);
    event.preventDefault();
    return false;
  });

}).call(this);
