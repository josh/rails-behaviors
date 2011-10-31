(function() {
  $(document).bind('ajaxBeforeSend', function(event, xhr, settings) {
    if (!settings.dataType) {
      xhr.setRequestHeader('Accept', '*/*;q=0.5, ' + settings.accepts.script);
    }
  });
}).call(this);
