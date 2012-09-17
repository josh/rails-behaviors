(function() {

  if (typeof Zepto === "undefined" || Zepto === null) {
    $.ajaxSetup({
      beforeSend: function(xhr, settings) {
        var element, event;
        if (!settings.global) {
          return;
        }
        element = settings.context || document;
        event = $.Event('ajaxBeforeSend');
        $(element).trigger(event, [xhr, settings]);
        if (event.isDefaultPrevented()) {
          return false;
        } else {
          return event.result;
        }
      }
    });
  }

}).call(this);
