$ ->
  fixture = $('#qunit-fixture')

  window.formSubmitted = ->

  module "CSRF"
    setup: ->
      window.formSubmitted = ->

    teardown: ->
      $(document).unbind '.test'
      $('#qunit-fixture').html ""

  asyncTest "adds X-CSRF-Token to AJAX requests if token header is present", ->
    token = "2705a83a5a0659cce34583972637eda5"
    meta = document.createElement 'meta'
    $(meta).attr name: 'csrf-token', content: token
    fixture.append meta

    $.ajax
      type: 'POST'
      url: "/echo"
      dataType: 'json'
      success: (env) ->
        equal token, env['HTTP_X_CSRF_TOKEN']
        start()

  asyncTest "doesn't add X-CSRF-Token to AJAX requests if no token header is present", ->
    $.ajax
      type: 'POST'
      url: "/echo"
      dataType: 'json'
      success: (env) ->
        ok !env['HTTP_X_CSRF_TOKEN']
        start()

  if $.support?.cors
    asyncTest "doesn't add X-CSRF-Token to cross domain JSONP requests", ->
      token = "2705a83a5a0659cce34583972637eda5"
      meta = $("<meta name=csrf-token content=#{token}>")
      fixture.append meta

      $.ajax
        url: "/echo"
        crossDomain: true
        success: (env) ->
          ok !env['HTTP_X_CSRF_TOKEN']
          start()

  asyncTest "doesn't add X-CSRF-Token to GET AJAX requests", ->
    token = "2705a83a5a0659cce34583972637eda5"
    meta = document.createElement 'meta'
    $(meta).attr name: 'csrf-token', content: token
    fixture.append meta

    $.ajax
      type: 'GET'
      url: "/echo"
      dataType: 'json'
      success: (env) ->
        ok !env['HTTP_X_CSRF_TOKEN']
        start()

  asyncTest "link is submitted with CSRF token", ->
    metaParam = $("<meta content=authenticity_token name=csrf-param>")
    fixture.append metaParam

    token = "2705a83a5a0659cce34583972637eda5"
    metaToken = $("<meta name=csrf-token content=#{token}>")
    fixture.append metaToken

    link = $("<a data-method=post href='/echo?iframe=1&callback=formSubmitted'>")
    fixture.append link

    link.trigger 'click'

    window.formSubmitted = (data) ->
      equal token, data.params['authenticity_token']
      start()

  asyncTest "adds X-CSRF-Token to POST forms if token header is present", ->
    metaParam = $("<meta content=authenticity_token name=csrf-param>")
    fixture.append metaParam

    token = "2705a83a5a0659cce34583972637eda5"
    metaToken = $("<meta name=csrf-token content=#{token}>")
    fixture.append metaToken

    form = $("<form action='/echo?iframe=1&callback=formSubmitted' method=POST></form>")
    fixture.append form

    submit = $(form).submit()

    window.formSubmitted = (data) ->
      equal token, data.params['authenticity_token']
      start()

  asyncTest "doesn't add X-CSRF-Token to GET forms", ->
    metaParam = $("<meta content=authenticity_token name=csrf-param>")
    fixture.append metaParam

    token = "2705a83a5a0659cce34583972637eda5"
    metaToken = $("<meta name=csrf-token content=#{token}>")
    fixture.append metaToken

    form = $("<form action='/echo' method=GET><input type=hidden name=iframe value=1><input type=hidden name=callback value=formSubmitted></form>")
    fixture.append form

    submit = $(form).submit()

    window.formSubmitted = (data) ->
      ok !data.params['authenticity_token']
      start()
