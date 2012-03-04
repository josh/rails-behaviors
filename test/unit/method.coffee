module "Method"
  setup: ->
    setupFrame this, "/frame"
    window.formSubmitted = ->

  teardown: ->
    delete window.formSubmitted

asyncTest "link is submitted with GET method", 1, ->
  @window.clickLink = ->
    ok true
    start()
    return

  link = @$("<a data-method=get href='javascript:clickLink();'>").appendTo('body')

  click link[0]

asyncTest "link is submitted with POST method", 2, ->
  link = @$("<a data-method=post href='/echo?iframe=1&callback=formSubmitted'>").appendTo('body')

  window.formSubmitted = (data) ->
    equal 'POST', data.REQUEST_METHOD
    equal '/echo', data.REQUEST_PATH
    start()

  click link[0]

asyncTest "link is submitted with PUT method", 2, ->
  link = @$("<a data-method=put href='/echo?iframe=1&callback=formSubmitted'>").appendTo('body')

  window.formSubmitted = (data) ->
    equal 'PUT', data.REQUEST_METHOD
    equal '/echo', data.REQUEST_PATH
    start()

  click link[0]

asyncTest "link is submitted with DELETE method", 2, ->
  link = @$("<a data-method=delete href='/echo?iframe=1&callback=formSubmitted'>").appendTo('body')

  window.formSubmitted = (data) ->
    equal 'DELETE', data.REQUEST_METHOD
    equal '/echo', data.REQUEST_PATH
    start()

  click link[0]
