# Implements data-remote forms and links
#
# Compatible with most of the UJS options Rails 3 provides.
#
# Fork/rewrite of jquery-ujs rails adapter. Does alot less and may
# contain some GitHub specific conventions. Also full of Coffee Love.
# https://github.com/rails/jquery-ujs/blob/master/src/rails.js
#
# jQuery UJS provides custom ajax:* methods to hook into. However,
# jQuery already provides most of these global ajax events, so we'll
# use those instead. There is no global version of `beforeSend`, so
# `ajaxBeforeSend` is added to complement it.
# Reference: http://docs.jquery.com/Ajax_Events

beforeSend = (element) -> (xhr, settings) ->
  # Don't like that this needs to be restated, but overriding
  # beforeSend clears our global configuration in application.js
  if settings.dataType is undefined
    xhr.setRequestHeader 'Accept', '*/*;q=0.5, ' + settings.accepts.script

  # Provide a global version of the `beforeSend` callback
  event = $.Event 'ajaxBeforeSend'
  element.trigger event, xhr, settings
  event.result

# Intercept all clicked links with data-remote and turn
# it into a XHR request instead.
$(document).on 'click', 'a[data-remote]', (event) ->
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
$(document).on 'submit', 'form[data-remote]', (event) ->
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
