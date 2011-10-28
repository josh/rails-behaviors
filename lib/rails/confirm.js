(function() {
  $(document).delegate('a[data-confirm]', 'click', function(event) {
    var message;
    if (message = $(this).attr('data-confirm')) {
      if (!confirm(message)) {
        event.stopImmediatePropagation();
        return false;
      }
    }
  });
}).call(this);
