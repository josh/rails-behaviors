(function() {
  var beforeSend;
  beforeSend = function(element) {
    return function(xhr, settings) {
      var event;
      if (!settings.dataType) {
        xhr.setRequestHeader('Accept', '*/*;q=0.5, ' + settings.accepts.script);
      }
      event = $.Event('ajaxBeforeSend');
      element.trigger(event, xhr, settings);
      return event.result;
    };
  };
  $(document).delegate('a[data-remote]', 'click', function(event) {
    var dataType, element, settings, type, url;
    element = $(this);
    settings = {};
    settings.context = this;
    settings.beforeSend = beforeSend(element);
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
    return false;
  });
  $(document).delegate('form[data-remote]', 'submit', function(event) {
    var data, dataType, form, settings, type, url;
    form = $(this);
    settings = {};
    settings.context = this;
    settings.beforeSend = beforeSend(form);
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
    return false;
  });
}).call(this);
