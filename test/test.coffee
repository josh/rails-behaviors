#= require qunit
#= require rails
#= require_directory ./unit

window.setupFrame = (env, url) ->
  stop()

  env.iframe = document.createElement 'iframe'
  env.iframe.src = "/frame"
  env.iframe.onload = ->
    env.iframe.onload = ->

    env.window   = env.win = env.iframe.contentWindow
    env.document = env.doc = env.iframe.contentDocument
    env.$        = env.iframe.contentWindow.jQuery

    start()

  fixture = document.getElementById 'qunit-fixture'
  fixture.appendChild env.iframe

window.click = (element) ->
  event = document.createEvent 'MouseEvents'
  event.initEvent 'click', true, true
  element.dispatchEvent event


$(document).delegate 'a[href]', 'click', (event) ->
  return if event.defaultPrevented || event.isDefaultPrevented?()
  window.location = event.target.href
  return

# Target form submissions to iframe
guid = 1
$(document).bind 'submit', (event) ->
  return if event.defaultPrevented || event.isDefaultPrevented?()
  name   = "frame#{guid++}"
  iframe = $ "<iframe id=#{name} name=#{name}>"
  $(event.target).attr 'target', name
  $('#qunit-fixture').append iframe

if Zepto?
  $(document).bind 'ajaxSuccess', (event, xhr) ->
    if xhr.getResponseHeader('Content-Type') is 'application/javascript'
      eval xhr.responseText
