# Remote
#
#= require ./beforesend
#
# Implements `data-remote` for forms and links.
#
#
# ### Markup
#
# `<a>`
#
# ``` definition-table
# Attribute - Description
#
# `data-remote`
#   Enables remote behavior on the element if set to anything.
#
# `data-method`
#   Changes the method of the AJAX request. Defaults to `"get"`. Maps to
#   jQuery's [type](http://api.jquery.com/jQuery.ajax/).
#
# `href`
#   URL for AJAX request. Defaults to the current url. Maps to jQuery's
#   [`url`](http://api.jquery.com/jQuery.ajax/).
#
# `data-type`
#   Specify the data type of the response. Can be `"xml"`, `"json"`,
#   `"script"`, or `"html"`. Defaults to jQuery's *"intelligent guess"*
#   from the response content type. Maps to jQuery's
#   [`dataType`](http://api.jquery.com/jQuery.ajax/).
# ```
#
# ``` html
# <a href="/toggle" data-method="post" data-remote>Toggle</a>
# ```
#
# `<form>`
#
# ``` definition-table
# Attribute - Description
#
# `data-remote`
#   Enables remote behavior on the element if set to anything.
#
# `method`
#   Changes the method of the AJAX request. Defaults to `"get"`. Maps to
#   jQuery's [type](http://api.jquery.com/jQuery.ajax/).
#
# `action`
#   URL for AJAX request. Defaults to the current url. Maps to jQuery's
#   [`url`](http://api.jquery.com/jQuery.ajax/).
#
# `data-type`
#   Specify the data type of the response. Can be `"xml"`, `"json"`,
#   `"script"`, or `"html"`. Defaults to jQuery's *"intelligent guess"*
#   from the response content type. Maps to jQuery's
#   [`dataType`](http://api.jquery.com/jQuery.ajax/).
# ```
#
# ``` html
# <form action="/comment" method="post" data-remote></form>
# ```
#
#
# ### Events
#
# Use delegated jQuery's global AJAX events to handle successful
# and error states. See jQuery's [AJAX event
# documentation](http://docs.jquery.com/Ajax_Events) for a complete
# reference.
#
# `ajaxBeforeSend`
#
# This event, which is triggered before an Ajax request is started, allows you to modify the XMLHttpRequest object (setting additional headers, if need be.)
#
# ``` definition-table
# Property - Value
#
# Synchronicity  - Sync
# Bubbles        - Yes
# Cancelable     - Yes
# Default action - Sends request
# Target         - `a` or `form` element with `[data-remote]`
# Extra arguments
#   [`jqXHR`](http://api.jquery.com/jQuery.ajax/#jqXHR) - XMLHttpRequest like object
#   [`settings`](http://api.jquery.com/jQuery.ajax/#jQuery-ajax-settings) - Object passed as `$.ajax` settings
# ```
#
# `ajaxSuccess`
#
# This event is only called if the request was successful (no errors from the server, no errors with the data).
#
# ``` definition-table
# Property - Value
#
# Synchronicity  - Sync
# Bubbles        - Yes
# Cancelable     - No
# Target         - `a` or `form` element with `[data-remote]`
# Extra arguments
#   [`jqXHR`](http://api.jquery.com/jQuery.ajax/#jqXHR) - XMLHttpRequest like object
#   [`settings`](http://api.jquery.com/jQuery.ajax/#jQuery-ajax-settings) - Object passed as `$.ajax` settings
#   `data` - The data returned from the server
# ```
#
# `ajaxError`
#
# This event is only called if an error occurred with the request (you can never have both an error and a success callback with a request).
#
# ``` definition-table
# Property - Value
#
# Synchronicity  - Sync
# Bubbles        - Yes
# Cancelable     - No
# Target         - `a` or `form` element with `[data-remote]`
# Extra arguments
#   [`jqXHR`](http://api.jquery.com/jQuery.ajax/#jqXHR) - XMLHttpRequest like object
#   `textStatus` - `"timeout"`, `"error"`, `"abort"`, or `"parsererror"`
#   `errorThrown` - Exception object
# ```
#
# `ajaxComplete`
#
# This event is called regardless of if the request was successful, or not. You will always receive a complete callback, even for synchronous requests.
#
# ``` definition-table
# Property - Value
#
# Synchronicity  - Sync
# Bubbles        - Yes
# Cancelable     - No
# Target         - `a` or `form` element with `[data-remote]`
# Extra arguments
#   [`jqXHR`](http://api.jquery.com/jQuery.ajax/#jqXHR) - XMLHttpRequest like object
#   `textStatus` - `"timeout"`, `"error"`, `"abort"`, or `"parsererror"`
# ```
#
#     $(document).on 'ajaxBeforeSend', '.new-comment', ->
#        $(this).addClass 'loading'
#
#     $(document).on 'ajaxComplete', '.new-comment', ->
#        $(this).removeClass 'loading'
#
#     $(document).on 'ajaxSuccess', '.new-comment', (event, xhr, settings, data) ->
#       $('.comments').append data.commentHTML
#
#     $(document).on 'ajaxError', '.new-comment', ->
#       alert "Something went wrong!"
#


# Intercept all clicked links with data-remote and turn
# it into a XHR request instead.
$(document).on 'click', 'a[data-remote]', (event) ->
  element  = $(this)
  settings = {}

  # Setting `context` to the element will cause all global
  # AJAX events to bubble up from it.
  settings.context = this

  # Allow AJAX method to be changed using the `data-method` attribute
  #   <a href="/comment" data-remote data-method="post">
  if type = element.attr 'data-method'
    settings.type = type

  # Use anchor href as the AJAX url
  if url = this.href
    settings.url = url

  # Allow dataType to be changed using the `data-type` attribute
  #   <a href="/comment" data-remote data-type="json">
  if dataType = element.attr 'data-type'
    settings.dataType = dataType

  # Do it
  $.ajax settings

  # Prevent default action so we don't follow the link
  event.preventDefault()
  false

# Intercept all form submissions with data-remote and turn
# it into a XHR request instead.
$(document).on 'submit', 'form[data-remote]', (event) ->
  form     = $(this)
  settings = {}

  # Setting `context` to the form will cause all global
  # AJAX events to bubble up from it.
  settings.context = this

  # Use form method as the AJAX method
  if type = form.attr 'method'
    settings.type = type

  # Use form action as the AJAX url
  if url = this.action
    settings.url = url

  # Seralize form inputs
  if data = form.serializeArray()
    settings.data = data

  # Allow dataType to be changed using the `data-type` attribute
  #   <a href="/comment" data-remote data-type="json">
  if dataType = form.attr 'data-type'
    settings.dataType = dataType

  # Do it
  $.ajax settings

  # Prevent default action and don't actually submit the form
  event.preventDefault()
  false

# Hold a reference to sent XHR object.
$(document).on 'ajaxSend', '[data-remote]', (event, xhr) ->
  $(this).data 'remote-xhr', xhr
  return

# Clear reference to completed XHR object.
$(document).on 'ajaxComplete', '[data-remote]', (event, xhr) ->
  $(this).removeData? 'remote-xhr'
  return
