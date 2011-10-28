# Implements `data-remote` for forms and links.
#
#     <a href="/toggle" data-remote>Toggle</a>
#
#     <form action="/comment" data-remote></form>
#
# Use delegated jQuery's global AJAX events to handle successful
# and error states.
#
#     $(document).on 'ajaxBeforeSend', '.new-comment', ->
#        $(this).addClass 'loading'
#
#     $(document).on 'ajaxComplete', '.new-comment', ->
#        $(this).removeClass 'loading'
#
#     $(document).on 'ajaxSuccess', '.new-comment', (e, xhr, opts, data) ->
#       $('.comments).append data.commentHTML
#
#     $(document).on 'ajaxError', '.new-comment', ->
#       alert "Something went wrong!"
#

# jQuery already provides a handful of global AJAX events. However,
# there is no global version of `beforeSend`, so `ajaxBeforeSend` is
# added to complement it.
#
# Reference: http://docs.jquery.com/Ajax_Events
beforeSend = (element) -> (xhr, settings) ->
  # It'd be nice if we could set this globally once with `ajaxSetup`.
  # But it gets overriden too easy. Dunno.
  unless settings.dataType
    xhr.setRequestHeader 'Accept', '*/*;q=0.5, ' + settings.accepts.script

  # Provide a global version of the `beforeSend` callback
  event = $.Event 'ajaxBeforeSend'
  element.trigger event, xhr, settings
  event.result

# Intercept all clicked links with data-remote and turn
# it into a XHR request instead.
$(document).delegate 'a[data-remote]', 'click', (event) ->
  element  = $(this)
  settings = {}

  # Setting `context` to the element will cause all global
  # AJAX events to bubble up from it.
  settings.context = this

  # Use our `beforeSend` helper that emits a
  # global `ajaxBeforeSend` event
  settings.beforeSend = beforeSend element

  # Allow AJAX method to be changed using the `data-method` attribute
  #   <a href="/comment" data-remote data-method="post">
  if type = element.data 'method'
    settings.type = type

  # Use anchor href as the AJAX url
  if url = element.attr 'href'
    settings.url = url

  # Allow dataType to be changed using the `data-type` attribute
  #   <a href="/comment" data-remote data-type="json">
  if dataType = element.data 'type'
    settings.dataType = dataType

  # Do it
  $.ajax settings

  # Prevent default action so we don't follow the link
  return false

# Intercept all form submissions with data-remote and turn
# it into a XHR request instead.
$(document).delegate 'form[data-remote]', 'submit', (event) ->
  form     = $(this)
  settings = {}

  # Setting `context` to the form will cause all global
  # AJAX events to bubble up from it.
  settings.context = this

  # Use our `beforeSend` helper that emits a
  # global `ajaxBeforeSend` event
  settings.beforeSend = beforeSend form

  # Use form method as the AJAX method
  if type = form.attr 'method'
    settings.type = type

  # Use form action as the AJAX url
  if url = form.attr 'action'
    settings.url = url

  # Seralize form inputs
  if data = form.serializeArray()
    settings.data = data

  # Allow dataType to be changed using the `data-type` attribute
  #   <a href="/comment" data-remote data-type="json">
  if dataType = form.data 'type'
    settings.dataType = dataType

  # Do it
  $.ajax settings

  # Prevent default action and don't actually submit the form
  return false
