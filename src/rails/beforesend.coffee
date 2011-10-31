# jQuery already provides a handful of global AJAX events. However,
# there is no global version of `beforeSend`, so `ajaxBeforeSend` is
# added to complement it.
#
# Reference: http://docs.jquery.com/Ajax_Events
$.ajaxSetup
  beforeSend: (xhr, settings) ->
    if element = settings.context
      # Provide a global version of the `beforeSend` callback
      event = $.Event 'ajaxBeforeSend'
      $(element).trigger event, [xhr, settings]
      event.result
    else
      return
