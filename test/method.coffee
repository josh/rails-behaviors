$ ->
  module "Method"

  window.formSubmitted = ->

  asyncTest "link is submitted with GET method", ->
    expect 2

    link = $("<a data-method=get href='/echo?iframe=1&callback=formSubmitted'>")[0]
    document.body.appendChild link

    link.click()

    window.formSubmitted = (data) ->
      equal 'GET', data.REQUEST_METHOD
      equal '/echo', data.REQUEST_PATH

      $(link).remove()
      window.formSubmitted = ->

      start()

  asyncTest "link is submitted with POST method", ->
    expect 2

    link = $("<a data-method=post href='/echo?iframe=1&callback=formSubmitted'>")[0]
    document.body.appendChild link

    link.click()

    window.formSubmitted = (data) ->
      equal 'POST', data.REQUEST_METHOD
      equal '/echo', data.REQUEST_PATH

      $(link).remove()
      window.formSubmitted = ->

      start()

  asyncTest "link is submitted with PUT method", ->
    expect 2

    link = $("<a data-method=put href='/echo?iframe=1&callback=formSubmitted'>")[0]
    document.body.appendChild link

    link.click()

    window.formSubmitted = (data) ->
      equal 'PUT', data.REQUEST_METHOD
      equal '/echo', data.REQUEST_PATH

      $(link).remove()
      window.formSubmitted = ->

      start()

  asyncTest "link is submitted with DELETE method", ->
    expect 2

    link = $("<a data-method=delete href='/echo?iframe=1&callback=formSubmitted'>")[0]
    document.body.appendChild link

    link.click()

    window.formSubmitted = (data) ->
      equal 'DELETE', data.REQUEST_METHOD
      equal '/echo', data.REQUEST_PATH

      $(link).remove()
      window.formSubmitted = ->

      start()
