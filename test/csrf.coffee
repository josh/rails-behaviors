$ ->
  fixture = $('#qunit-fixture')

  window.formSubmitted = ->

  module "CSRF"
    setup: ->
      window.formSubmitted = ->

    teardown: ->
      $(document).undelegate '.test'
      $('#qunit-fixture').html ""

  asyncTest "adds X-CSRF-Token to AJAX requests if token header is present", ->
    token = "2705a83a5a0659cce34583972637eda5"
    meta = $("<meta name=csrf-token content=#{token}>")
    fixture.append meta

    $.post "/echo", (env) ->
      equal token, env['HTTP_X_CSRF_TOKEN']
      start()

  asyncTest "doesn't add X-CSRF-Token to AJAX requests if no token header is present", ->
    $.post "/echo", (env) ->
      ok !env['HTTP_X_CSRF_TOKEN']
      start()

  asyncTest "doesn't add X-CSRF-Token to cross domain JSONP requests", ->
    token = "2705a83a5a0659cce34583972637eda5"
    meta = $("<meta name=csrf-token content=#{token}>")[0]
    fixture.append meta

    $.ajax
      url: "/echo"
      crossDomain: true
      success: (env) ->
        ok !env['HTTP_X_CSRF_TOKEN']
        start()

  asyncTest "link is submitted with CSRF token", ->
    metaParam = $("<meta content=authenticity_token name=csrf-param>")[0]
    fixture.append metaParam

    token = "2705a83a5a0659cce34583972637eda5"
    metaToken = $("<meta name=csrf-token content=#{token}>")[0]
    fixture.append metaToken

    link = $("<a data-method=post href='/echo?iframe=1&callback=formSubmitted'>")
    fixture.append link

    link[0].click()

    window.formSubmitted = (data) ->
      equal token, data.params['authenticity_token']
      start()
