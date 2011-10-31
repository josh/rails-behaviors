$ ->
  fixture = $('#qunit-fixture')

  window.formSubmitted = ->

  module "Method"
    setup: ->
      window.formSubmitted = ->

    teardown: ->
      $(document).undelegate '.test'
      $('#qunit-fixture').html ""

  asyncTest "link is submitted with GET method", ->
    link = $("<a data-method=get href='/echo?iframe=1&callback=formSubmitted'>")
    fixture.append link

    link.trigger 'click'

    window.formSubmitted = (data) ->
      equal 'GET', data.REQUEST_METHOD
      equal '/echo', data.REQUEST_PATH
      start()

  asyncTest "link is submitted with POST method", ->
    link = $("<a data-method=post href='/echo?iframe=1&callback=formSubmitted'>")
    fixture.append link

    link.trigger 'click'

    window.formSubmitted = (data) ->
      equal 'POST', data.REQUEST_METHOD
      equal '/echo', data.REQUEST_PATH
      start()

  asyncTest "link is submitted with PUT method", ->
    link = $("<a data-method=put href='/echo?iframe=1&callback=formSubmitted'>")
    fixture.append link

    link.trigger 'click'

    window.formSubmitted = (data) ->
      equal 'PUT', data.REQUEST_METHOD
      equal '/echo', data.REQUEST_PATH
      start()

  asyncTest "link is submitted with DELETE method", ->
    link = $("<a data-method=delete href='/echo?iframe=1&callback=formSubmitted'>")
    fixture.append link

    link.trigger 'click'

    window.formSubmitted = (data) ->
      equal 'DELETE', data.REQUEST_METHOD
      equal '/echo', data.REQUEST_PATH
      start()
