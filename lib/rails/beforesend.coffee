# Implements global `ajaxBeforeSend` event.
#
# jQuery already provides a handful of global AJAX events. However,
# there is no global version of `beforeSend`, so `ajaxBeforeSend` is
# added to complement it.
#
# Reference: http://docs.jquery.com/Ajax_Events

# Skip for Zepto which doesn't have ajaxSetup but does already support
# `ajaxBeforeSend`. It'd be better to feature test for the event and
# see if we need to install it.
unless Zepto?

  # One caveat about using `$.ajaxSetup` is that its easily clobbered.
  # If anything else tries to register another global `beforeSend`
  # handler, ours will be overriden.
  #
  # To work around this, register your global `beforeSend` handler with:
  #
  #     $(document).on('ajaxBeforeSend', function() {})
  #
  $.ajaxSetup
    beforeSend: (xhr, settings) ->
      # Skip if global events are disabled
      return unless settings.global

      # Default to document if context isn't set
      element = settings.context || document

      # Provide a global version of the `beforeSend` callback
      event = $.Event 'ajaxBeforeSend'
      $(element).trigger event, [xhr, settings]
      if event.isDefaultPrevented() then false else event.result
