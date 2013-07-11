#= require qunit
#= require_self
#= require_directory ./unit

window.frameworks = ["jquery-1.7.2", "jquery-1.8.3", "jquery-1.9.1", "jquery-2.0.3", "zepto-1.0"]

window.each = (array, block) ->
  for item in array
    block item
  return

window.setupFrame = (env, url) ->
  stop()

  env.iframe = document.createElement 'iframe'
  env.iframe.src = url
  env.iframe.onload = ->
    env.iframe.onload = ->

    env.window   = env.win = env.iframe.contentWindow
    env.document = env.doc = env.iframe.contentDocument
    env.$        = env.iframe.contentWindow.$

    start()

  fixture = document.getElementById 'qunit-fixture'
  fixture.appendChild env.iframe

window.click = (element) ->
  event = document.createEvent 'MouseEvents'
  event.initEvent 'click', true, true
  element.dispatchEvent event
