# Accept
#
#= require ./beforesend
#
# Make default Accept header prefer JS.
#
# jQuery's default Accept header is just `"*/*"`, which means accept
# anything back. To make AJAX requests work nicer with Rails'
# `respond_to` block, this prioritizes JS responds over others.
#
# For an example:
#
#     respond_to do |format|
#       format.html
#       format.js
#     end
#
# Would return `html` for `"*/*"` just because its first in the list.
# Adjusting the Accept header makes it work as expected.
#
# Otherwise, if there is no `format.js`, the first responder will be used.
#
# The new Accept value is:
#
#     "*/*;q=0.5, text/javascript, application/javascript,
#      application/ecmascript, application/x-ecmascript"
#

$(document).on 'ajaxBeforeSend', (event, xhr, settings) ->
  unless settings.dataType
    xhr.setRequestHeader 'Accept', '*/*;q=0.5, ' + settings.accepts.script
