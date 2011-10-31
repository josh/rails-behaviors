(function() {
  if (!$.ajaxSetup) {
    return;
  }
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
