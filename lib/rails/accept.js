(function() {
  $.ajaxSetup({
    beforeSend: function(xhr, settings) {
      var element, event;
      if (element = settings.context) {
        event = $.Event('ajaxBeforeSend');
        $(element).trigger(event, [xhr, settings]);
        return event.result;
      } else {

      }
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
