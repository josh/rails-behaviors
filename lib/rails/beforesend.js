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
