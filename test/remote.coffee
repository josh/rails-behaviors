$ ->
  fixture = $('#qunit-fixture')

  window.formSubmitted = ->

  module "Remote"
    setup: ->
      window.formSubmitted = ->

    teardown: ->
      $(document).undelegate '.test'
      $('#qunit-fixture').html ""

  asyncTest "link is submitted via AJAX with GET method", ->
    link = $("<a data-remote href='/echo?callback=formSubmitted'>")
    fixture.append link

    window.formSubmitted = (data) ->
      equal 'GET', data.REQUEST_METHOD
      equal '/echo', data.REQUEST_PATH
      start()

    link[0].click()

  asyncTest "link is submitted via AJAX with POST method", ->
    link = $("<a data-remote data-method=post href='/echo?callback=formSubmitted'>")
    fixture.append link

    window.formSubmitted = (data) ->
      equal 'POST', data.REQUEST_METHOD
      equal '/echo', data.REQUEST_PATH
      start()

    link[0].click()

  asyncTest "link is submitted via AJAX with PUT method", ->
    link = $("<a data-remote data-method=put href='/echo?callback=formSubmitted'>")
    fixture.append link

    window.formSubmitted = (data) ->
      equal 'PUT', data.REQUEST_METHOD
      equal '/echo', data.REQUEST_PATH
      start()

    link[0].click()

  asyncTest "link is submitted via AJAX with DELETE method", ->
    link = $("<a data-remote data-method=delete href='/echo?callback=formSubmitted'>")
    fixture.append link

    window.formSubmitted = (data) ->
      equal 'DELETE', data.REQUEST_METHOD
      equal '/echo', data.REQUEST_PATH
      start()

    link[0].click()

  asyncTest "link is submitted via AJAX that accepts JSON", ->
    link = $("<a data-remote href='/echo' data-type=json>")
    fixture.append link

    $(document).delegate 'a', 'ajaxSuccess.test', (event, xhr, settings, data) ->
      equal 'GET', data.REQUEST_METHOD
      equal '/echo', data.REQUEST_PATH
      start()

    link[0].click()

  asyncTest "link is prevented from being submitted", ->
    link = $("<a data-remote href='/echo'>")
    fixture.append link

    $(document).delegate 'a', 'ajaxBeforeSend.test', ->
      ok true
      false

    $(document).delegate 'a', 'ajaxSuccess.test', ->
      ok false

    link[0].click()

    setTimeout (-> start()), 50


  asyncTest "form is submitted via AJAX with GET method", ->
    form = $("<form data-remote action='/echo?callback=formSubmitted'><input name=foo value=bar></form>")
    fixture.append form

    window.formSubmitted = (data) ->
      equal 'GET', data.REQUEST_METHOD
      equal '/echo', data.REQUEST_PATH
      equal 'bar', data.params['foo']
      start()

    $(form).submit()

  asyncTest "form is submitted via AJAX with POST method", ->
    form = $("<form data-remote method=post action='/echo?callback=formSubmitted'><input name=foo value=bar></form>")
    fixture.append form

    window.formSubmitted = (data) ->
      equal 'POST', data.REQUEST_METHOD
      equal '/echo', data.REQUEST_PATH
      equal 'bar', data.params['foo']
      start()

    $(form).submit()

  asyncTest "form is submitted via AJAX with PUT method", ->
    form = $("<form data-remote method=put action='/echo?callback=formSubmitted'><input name=foo value=bar></form>")
    fixture.append form

    window.formSubmitted = (data) ->
      equal 'PUT', data.REQUEST_METHOD
      equal '/echo', data.REQUEST_PATH
      equal 'bar', data.params['foo']
      start()

    $(form).submit()

  asyncTest "form is submitted via AJAX with DELETE method", ->
    form = $("<form data-remote method=delete action='/echo?callback=formSubmitted'><input name=foo value=bar></form>")
    fixture.append form

    window.formSubmitted = (data) ->
      equal 'DELETE', data.REQUEST_METHOD
      equal '/echo', data.REQUEST_PATH
      equal 'bar', data.params['foo']
      start()

    $(form).submit()

  asyncTest "form is submitted via AJAX that accepts JSON", ->
    form = $("<form data-remote data-type=json action='/echo'><input name=foo value=bar></form>")
    fixture.append form

    $(document).delegate 'form', 'ajaxSuccess.test', (event, xhr, settings, data) ->
      equal 'GET', data.REQUEST_METHOD
      equal '/echo', data.REQUEST_PATH
      equal 'bar', data.params['foo']
      start()

    $(form).submit()

  asyncTest "form is prevented from being submitted", ->
    form = $("<form data-remote data-type=json action='/echo'><input name=foo value=bar></form>")
    fixture.append form

    $(document).delegate 'form', 'ajaxBeforeSend.test', ->
      ok true
      false

    $(document).delegate 'form', 'ajaxSuccess.test', ->
      ok false

    $(form).submit()

    setTimeout (-> start()), 50
