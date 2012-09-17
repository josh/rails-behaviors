(function() {

  $(document).on('click:prepare', 'a[data-confirm], button[data-confirm]', function(event) {
    var message;
    if (message = $(this).attr('data-confirm')) {
      if (!confirm(message)) {
        event.stopImmediatePropagation();
        event.preventDefault();
      }
    }
  });

}).call(this);
