#= require qunit
#= require_self
#= require_directory ./unit

window.frameworks = ["jquery", "zepto"]

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
