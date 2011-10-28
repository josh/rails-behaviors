$ ->
  module "Remote"

  window.formSubmitted = ->

  asyncTest "link is submitted via AJAX with GET method", ->
    expect 2

    link = $("<a data-remote href='/echo?callback=formSubmitted'>")[0]
    document.body.appendChild link

    window.formSubmitted = (data) ->
      equal 'GET', data.REQUEST_METHOD
      equal '/echo', data.REQUEST_PATH

      $(link).remove()
      window.formSubmitted = ->

      start()

    link.click()

  asyncTest "link is submitted via AJAX with POST method", ->
    expect 2

    link = $("<a data-remote data-method=post href='/echo?callback=formSubmitted'>")[0]
    document.body.appendChild link

    window.formSubmitted = (data) ->
      equal 'POST', data.REQUEST_METHOD
      equal '/echo', data.REQUEST_PATH

      $(link).remove()
      window.formSubmitted = ->

      start()

    link.click()

  asyncTest "link is submitted via AJAX with PUT method", ->
    expect 2

    link = $("<a data-remote data-method=put href='/echo?callback=formSubmitted'>")[0]
    document.body.appendChild link

    window.formSubmitted = (data) ->
      equal 'PUT', data.REQUEST_METHOD
      equal '/echo', data.REQUEST_PATH

      $(link).remove()
      window.formSubmitted = ->

      start()

    link.click()

  asyncTest "link is submitted via AJAX with DELETE method", ->
    expect 2

    link = $("<a data-remote data-method=delete href='/echo?callback=formSubmitted'>")[0]
    document.body.appendChild link

    window.formSubmitted = (data) ->
      equal 'DELETE', data.REQUEST_METHOD
      equal '/echo', data.REQUEST_PATH

      $(link).remove()
      window.formSubmitted = ->

      start()

    link.click()

  asyncTest "link is submitted via AJAX that accepts JSON", ->
    expect 2

    link = $("<a data-remote href='/echo' data-type=json>")[0]
    document.body.appendChild link

    $(document).delegate 'a', 'ajaxSuccess.test', (event, xhr, settings, data) ->
      equal 'GET', data.REQUEST_METHOD
      equal '/echo', data.REQUEST_PATH

      $(document).undelegate 'ajaxSuccess.test'
      $(link).remove()

      start()

    link.click()

  asyncTest "link is prevented from being submitted", ->
    expect 1
    link = $("<a data-remote href='/echo'>")[0]
    document.body.appendChild link

    $(document).delegate 'a', 'ajaxBeforeSend.test', ->
      ok true
      false

    $(document).delegate 'a', 'ajaxSuccess.test', ->
      ok false

    link.click()

    setTimeout ->
      $(document).undelegate 'ajaxBeforeSend.test'
      $(document).undelegate 'ajaxSuccess.test'
      $(link).remove()
      start()
    , 50


  asyncTest "form is submitted via AJAX with GET method", ->
    expect 3

    form = $("<form data-remote action='/echo?callback=formSubmitted'><input name=foo value=bar></form>")[0]
    document.body.appendChild form

    window.formSubmitted = (data) ->
      equal 'GET', data.REQUEST_METHOD
      equal '/echo', data.REQUEST_PATH
      equal 'bar', data.params['foo']

      $(form).remove()
      window.formSubmitted = ->

      start()

    $(form).submit()

  asyncTest "form is submitted via AJAX with POST method", ->
    expect 3

    form = $("<form data-remote method=post action='/echo?callback=formSubmitted'><input name=foo value=bar></form>")[0]
    document.body.appendChild form

    window.formSubmitted = (data) ->
      equal 'POST', data.REQUEST_METHOD
      equal '/echo', data.REQUEST_PATH
      equal 'bar', data.params['foo']

      $(form).remove()
      window.formSubmitted = ->

      start()

    $(form).submit()

  asyncTest "form is submitted via AJAX with PUT method", ->
    expect 3

    form = $("<form data-remote method=put action='/echo?callback=formSubmitted'><input name=foo value=bar></form>")[0]
    document.body.appendChild form

    window.formSubmitted = (data) ->
      equal 'PUT', data.REQUEST_METHOD
      equal '/echo', data.REQUEST_PATH
      equal 'bar', data.params['foo']

      $(form).remove()
      window.formSubmitted = ->

      start()

    $(form).submit()

  asyncTest "form is submitted via AJAX with DELETE method", ->
    expect 3

    form = $("<form data-remote method=delete action='/echo?callback=formSubmitted'><input name=foo value=bar></form>")[0]
    document.body.appendChild form

    window.formSubmitted = (data) ->
      equal 'DELETE', data.REQUEST_METHOD
      equal '/echo', data.REQUEST_PATH
      equal 'bar', data.params['foo']

      $(form).remove()
      window.formSubmitted = ->

      start()

    $(form).submit()

  asyncTest "form is submitted via AJAX that accepts JSON", ->
    expect 3

    form = $("<form data-remote data-type=json action='/echo'><input name=foo value=bar></form>")[0]
    document.body.appendChild form

    $(document).delegate 'form', 'ajaxSuccess.test', (event, xhr, settings, data) ->
      equal 'GET', data.REQUEST_METHOD
      equal '/echo', data.REQUEST_PATH
      equal 'bar', data.params['foo']

      $(document).undelegate 'ajaxSuccess.test'
      $(form).remove()

      start()

    $(form).submit()

  asyncTest "form is prevented from being submitted", ->
    expect 1

    form = $("<form data-remote data-type=json action='/echo'><input name=foo value=bar></form>")[0]
    document.body.appendChild form

    $(document).delegate 'form', 'ajaxBeforeSend.test', ->
      ok true
      false

    $(document).delegate 'form', 'ajaxSuccess.test', ->
      ok false

    $(form).submit()

    setTimeout ->
      $(document).undelegate 'ajaxBeforeSend.test'
      $(document).undelegate 'ajaxSuccess.test'
      $(form).remove()
      start()
    , 50
