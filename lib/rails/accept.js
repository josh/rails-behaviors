(function() {

  $(document).on('ajaxBeforeSend', function(event, xhr, settings) {
    if (!settings.dataType) {
      return xhr.setRequestHeader('Accept', '*/*;q=0.5, ' + settings.accepts.script);
    }
  });

}).call(this);
