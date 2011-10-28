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

$(document).on 'click', 'a[data-method]', (event) ->
  element = $(this)

  # Don't handle remote requests
  return if element.is 'a[data-remote]'

  form = document.createElement 'form'
  $(form).attr
    method: 'post'
    action: element.attr 'href'
    style:  'display:none;'

  input = document.createElement 'input'
  $(input).attr
    type:  'hidden'
    name:  '_method'
    value: element.attr 'data-method'
  form.appendChild input

  csrfToken = $('meta[name="csrf-token"]').attr 'content'
  csrfParam = $('meta[name="csrf-param"]').attr 'content'

  if csrfToken? and csrfParam?
    input = document.createElement 'input'
    $(input).attr
      type:  'hidden'
      name:  csrfParam
      value: csrfToken
    form.appendChild input

  document.body.appendChild form
  $(form).submit()

  return false

$(document).on 'click', 'a[data-remote]', (event) ->
  element  = $(this)
  settings = {}

  settings.context = this
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

  $.ajax settings

  return false

$(document).on 'submit', 'form[data-remote]', (event) ->
  form     = $(this)
  settings = {}

  settings.context = this
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

  $.ajax settings

  return false
