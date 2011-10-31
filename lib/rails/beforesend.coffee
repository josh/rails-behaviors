# jQuery already provides a handful of global AJAX events. However,
# there is no global version of `beforeSend`, so `ajaxBeforeSend` is
# added to complement it.
#
# Reference: http://docs.jquery.com/Ajax_Events

return unless $.ajaxSetup

$.ajaxSetup
  beforeSend: (xhr, settings) ->
    return unless settings.global

    # Default to document if context isn't set
    element = settings.context || document

    # Provide a global version of the `beforeSend` callback
    event = $.Event 'ajaxBeforeSend'
    $(element).trigger event, [xhr, settings]
    event.result
