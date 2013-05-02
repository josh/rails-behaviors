each frameworks, (framework) ->
  module "#{framework} - Remote",
    setup: ->
      setupFrame this, "/#{framework}.html"

  asyncTest "link is submitted via AJAX with GET method", 2, ->
    link = @$("<a data-remote href='/echo?callback=formSubmitted'>").appendTo('body')

    @window.formSubmitted = (data) ->
      equal 'GET', data.REQUEST_METHOD
      equal '/echo', data.REQUEST_PATH
      start()

    click link[0]

  asyncTest "link is submitted via AJAX with POST method", 2, ->
    link = @$("<a data-remote data-method=post href='/echo?callback=formSubmitted'>").appendTo('body')

    @window.formSubmitted = (data) ->
      equal 'POST', data.REQUEST_METHOD
      equal '/echo', data.REQUEST_PATH
      start()

    click link[0]

  asyncTest "link is submitted via AJAX with PUT method", 2, ->
    link = @$("<a data-remote data-method=put href='/echo?callback=formSubmitted'>").appendTo('body')

    @window.formSubmitted = (data) ->
      equal 'PUT', data.REQUEST_METHOD
      equal '/echo', data.REQUEST_PATH
      start()

    click link[0]

  asyncTest "link is submitted via AJAX with DELETE method", 2, ->
    link = @$("<a data-remote data-method=delete href='/echo?callback=formSubmitted'>").appendTo('body')

    @window.formSubmitted = (data) ->
      equal 'DELETE', data.REQUEST_METHOD
      equal '/echo', data.REQUEST_PATH
      start()

    click link[0]

  asyncTest "link is submitted via AJAX that accepts JSON", 2, ->
    link = @$("<a data-remote href='/echo' data-type=json>").appendTo('body')

    @$(@document).on 'ajaxSuccess.test', 'a', (event, xhr, settings, data) ->
      equal 'GET', data.REQUEST_METHOD
      equal '/echo', data.REQUEST_PATH
      start()

    click link[0]

  asyncTest "link is prevented from being submitted", 1, ->
    link = @$("<a data-remote href='/echo'>").appendTo('body')

    @$(@document).on 'ajaxBeforeSend.test', 'a', ->
      ok true
      false

    @$(@document).on 'ajaxSuccess.test', 'a', ->
      ok false

    click link[0]

    setTimeout (-> start()), 50

  asyncTest "link xhr is exposed via data remote-xhr", 2, ->
    link = @$("<a data-remote href='/echo'>").appendTo('body')

    @$(@document).on 'ajaxSend.test', 'a', ->
      ok link.data 'remote-xhr'

    @$(@document).on 'ajaxSuccess.test', 'a', =>
      setTimeout =>
        if @$.fn.removeData
          ok !link.data('remote-xhr')
        else
          ok true
        start()
      , 0

    click link[0]


  asyncTest "form is submitted via AJAX with GET method", 3, ->
    form = @$("<form data-remote action='/echo?callback=formSubmitted'><input name=foo value=bar></form>").appendTo('body')

    @window.formSubmitted = (data) ->
      equal 'GET', data.REQUEST_METHOD
      equal '/echo', data.REQUEST_PATH
      equal 'bar', data.params['foo']
      start()

    form.submit()

  asyncTest "form is submitted via AJAX with POST method", 3, ->
    form = @$("<form data-remote method=post action='/echo?callback=formSubmitted'><input name=foo value=bar></form>").appendTo('body')

    @window.formSubmitted = (data) ->
      equal 'POST', data.REQUEST_METHOD
      equal '/echo', data.REQUEST_PATH
      equal 'bar', data.params['foo']
      start()

    form.submit()

  asyncTest "form is submitted via AJAX with PUT method", 3, ->
    form = @$("<form data-remote method=put action='/echo?callback=formSubmitted'><input name=foo value=bar></form>").appendTo('body')

    @window.formSubmitted = (data) ->
      equal 'PUT', data.REQUEST_METHOD
      equal '/echo', data.REQUEST_PATH
      equal 'bar', data.params['foo']
      start()

    form.submit()

  asyncTest "form is submitted via AJAX with DELETE method", 2, ->
    form = @$("<form data-remote method=delete action='/echo?callback=formSubmitted'></form>").appendTo('body')

    @window.formSubmitted = (data) ->
      equal 'DELETE', data.REQUEST_METHOD
      equal '/echo', data.REQUEST_PATH
      start()

    form.submit()

  asyncTest "form is submitted via AJAX that accepts JSON", 3, ->
    form = @$("<form data-remote data-type=json action='/echo'><input name=foo value=bar></form>").appendTo('body')

    @$(@document).on 'ajaxSuccess.test', 'form', (event, xhr, settings, data) ->
      equal 'GET', data.REQUEST_METHOD
      equal '/echo', data.REQUEST_PATH
      equal 'bar', data.params['foo']
      start()

    form.submit()

  asyncTest "form is prevented from being submitted", 1, ->
    form = @$("<form data-remote data-type=json action='/echo'><input name=foo value=bar></form>").appendTo('body')

    @$(@document).on 'ajaxBeforeSend.test', 'form', ->
      ok true
      false

    @$(@document).on 'ajaxSuccess.test', 'form', ->
      ok false

    form.submit()

    setTimeout (-> start()), 50

  asyncTest "form xhr is exposed via data remote-xhr", 2, ->
    form = @$("<form data-remote action='/echo'><input name=foo value=bar></form>").appendTo('body')

    @$(@document).on 'ajaxSend.test', 'form', ->
      ok form.data 'remote-xhr'

    @$(@document).on 'ajaxSuccess.test', 'form', =>
      setTimeout =>
        if @$.fn.removeData
          ok !form.data('remote-xhr')
        else
          ok true
        start()
      , 0

    form.submit()
