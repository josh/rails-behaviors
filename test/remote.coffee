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

