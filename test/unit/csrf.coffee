each frameworks, (framework) ->
  module "#{framework} - CSRF",
    setup: ->
      setupFrame this, "/#{framework}.html"
      window.formSubmitted = ->

    teardown: ->
      delete window.formSubmitted

  asyncTest "adds X-CSRF-Token to AJAX requests if token header is present", ->
    token = "2705a83a5a0659cce34583972637eda5"
    @$("<meta name=csrf-token content=#{token}>").appendTo('body')

    @$.ajax
      type: 'POST'
      url: "/echo"
      dataType: 'json'
      success: (env) ->
        equal token, env['HTTP_X_CSRF_TOKEN']
        start()

  asyncTest "doesn't add X-CSRF-Token to AJAX requests if no token header is present", ->
    @$.ajax
      type: 'POST'
      url: "/echo"
      dataType: 'json'
      success: (env) ->
        ok !env['HTTP_X_CSRF_TOKEN']
        start()

  asyncTest "doesn't add X-CSRF-Token to cross domain JSONP requests", ->
    unless @$.support?.cors
      ok true
      return start()

    token = "2705a83a5a0659cce34583972637eda5"
    @$("<meta name=csrf-token content=#{token}>").appendTo('body')

    @$.ajax
      url: "/echo"
      crossDomain: true
      success: (env) ->
        ok !env['HTTP_X_CSRF_TOKEN']
        start()

  asyncTest "doesn't add X-CSRF-Token to GET AJAX requests", ->
    token = "2705a83a5a0659cce34583972637eda5"
    @$("<meta name=csrf-token content=#{token}>").appendTo('body')

    @$.ajax
      type: 'GET'
      url: "/echo"
      dataType: 'json'
      success: (env) ->
        ok !env['HTTP_X_CSRF_TOKEN']
        start()

  asyncTest "link is submitted with CSRF token", ->
    token = "2705a83a5a0659cce34583972637eda5"
    @$("<meta content=authenticity_token name=csrf-param>").appendTo('body')
    @$("<meta name=csrf-token content=#{token}>").appendTo('body')
    link = @$("<a data-method=post href='/echo?iframe=1&callback=formSubmitted'>").appendTo('body')

    window.formSubmitted = (data) ->
      equal token, data.params['authenticity_token']
      start()

    click link[0]

  asyncTest "adds X-CSRF-Token to POST forms if token header is present", ->
    token = "2705a83a5a0659cce34583972637eda5"
    @$("<meta content=authenticity_token name=csrf-param>").appendTo('body')
    @$("<meta name=csrf-token content=#{token}>").appendTo('body')

    form = @$("<form action='/echo?iframe=1&callback=formSubmitted' method=POST></form>").appendTo('body')

    window.formSubmitted = (data) ->
      equal token, data.params['authenticity_token']
      start()

    form.submit()

  asyncTest "adds X-CSRF-Token to POST forms when URL contains basic auth credentials", ->
    token = "2705a83a5a0659cce34583972637eda5"
    @$("<meta content=authenticity_token name=csrf-param>").appendTo('body')
    @$("<meta name=csrf-token content=#{token}>").appendTo('body')

    form = @$("<form action='#{@window.location.protocol}//username:password@#{@window.location.host}/echo?iframe=1&callback=formSubmitted' method=POST></form>").appendTo('body')

    window.formSubmitted = (data) ->
      equal token, data.params['authenticity_token']
      start()

    form.submit()

  asyncTest "doesn't add X-CSRF-Token to GET forms", ->
    token = "2705a83a5a0659cce34583972637eda5"
    @$("<meta content=authenticity_token name=csrf-param>").appendTo('body')
    @$("<meta name=csrf-token content=#{token}>").appendTo('body')

    form = @$("<form action='/echo' method=GET><input type=hidden name=iframe value=1><input type=hidden name=callback value=formSubmitted></form>").appendTo('body')

    window.formSubmitted = (data) ->
      ok !data.params['authenticity_token']
      start()

    form.submit()
