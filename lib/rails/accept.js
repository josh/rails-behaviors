(function() {
  $.ajaxSetup({
    beforeSend: function(xhr, settings) {
      var element, event;
      if (!settings.global) {
        return;
      }
      element = settings.context || document;
      event = $.Event('ajaxBeforeSend');
      $(element).trigger(event, [xhr, settings]);
      return event.result;
    }
  });
}).call(this);
(function() {
  $(document).bind('ajaxBeforeSend', function(event, xhr, settings) {
    if (!settings.dataType) {
      xhr.setRequestHeader('Accept', '*/*;q=0.5, ' + settings.accepts.script);
    }
  });
}).call(this);
