$ ->
  module "CSRF"

  window.formSubmitted = ->

  asyncTest "adds X-CSRF-Token to AJAX requests if token header is present", ->
    expect 1

    token = "2705a83a5a0659cce34583972637eda5"
    meta = $("<meta name=csrf-token content=#{token}>")[0]
    document.head.appendChild meta

    $.post "/echo", (env) ->
      equal token, env['HTTP_X_CSRF_TOKEN']

      $(meta).remove()
      start()

  asyncTest "doesn't add X-CSRF-Token to AJAX requests if no token header is present", ->
    expect 1

    $.post "/echo", (env) ->
      ok !env['HTTP_X_CSRF_TOKEN']

      start()

  asyncTest "doesn't add X-CSRF-Token to cross domain JSONP requests", ->
    expect 1

    token = "2705a83a5a0659cce34583972637eda5"
    meta = $("<meta name=csrf-token content=#{token}>")[0]
    document.head.appendChild meta

    $.ajax
      url: "/echo"
      crossDomain: true
      success: (env) ->
        ok !env['HTTP_X_CSRF_TOKEN']

        $(meta).remove()
        start()

  asyncTest "link is submitted with CSRF token", ->
    expect 1

    metaParam = $("<meta content=authenticity_token name=csrf-param>")[0]
    document.head.appendChild metaParam

    token = "2705a83a5a0659cce34583972637eda5"
    metaToken = $("<meta name=csrf-token content=#{token}>")[0]
    document.head.appendChild metaToken

    link = $("<a data-method=post href='/echo?callback=formSubmitted'>")[0]
    document.body.appendChild link

    link.click()

    window.formSubmitted = (data) ->
      equal token, data.params['authenticity_token']

      $(link).remove()
      $(metaParam).remove()
      $(metaToken).remove()
      window.formSubmitted = ->

      start()
