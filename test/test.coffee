#= require qunit
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
