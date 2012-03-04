each frameworks, (framework) ->
  module "#{framework} - Disable",
    setup: ->
      setupFrame this, "/#{framework}.html"
      window.formSubmitted = ->

    teardown: ->
      delete window.formSubmitted

  asyncTest "submit input with default value is disabled", 3, ->
    form = @$("<form action='/echo?iframe=1&callback=formSubmitted' method=post><input type=submit data-disable-with='Submitting...'></form>").appendTo('body')

    submit = form.find('input[type=submit]')

    window.formSubmitted = ->
      start()

    equal "", submit.val()
    click submit[0]
    ok submit[0].disabled
    equal "Submitting...", submit.val()

  asyncTest "submit input is disabled", 3, ->
    form = @$("<form action='/echo?iframe=1&callback=formSubmitted' method=post><input type=submit value='Comment' data-disable-with='Commenting...'></form>").appendTo('body')

    submit = form.find('input[type=submit]')

    window.formSubmitted = ->
      start()

    equal "Comment", submit.val()
    click submit[0]
    ok submit[0].disabled
    equal "Commenting...", submit.val()

  asyncTest "submit input is disabled with default text", 3, ->
    form = @$("<form action='/echo?iframe=1&callback=formSubmitted' method=post><input type=submit value='Comment' data-disable-with></form>").appendTo('body')

    submit = form.find('input[type=submit]')

    window.formSubmitted = ->
      start()

    equal "Comment", submit.val()
    click submit[0]
    ok submit[0].disabled
    equal "Comment", submit.val()

  asyncTest "submit button is disabled", 3, ->
    form = @$("<form action='/echo?iframe=1&callback=formSubmitted' method=post><button type=submit data-disable-with='Commenting...'>Comment</button></form>").appendTo('body')

    submit = form.find('button[type=submit]')

    window.formSubmitted = ->
      start()

    equal "Comment", submit.text()
    click submit[0]
    ok submit[0].disabled
    equal "Commenting...", submit.text()


  asyncTest "submit button is disabled with default text", 3, ->
    form = @$("<form action='/echo?iframe=1&callback=formSubmitted' method=post><button type=submit data-disable-with>Comment</button></form>").appendTo('body')

    submit = form.find('button[type=submit]')

    window.formSubmitted = ->
      start()

    equal "Comment", submit.text()
    click submit[0]
    ok submit[0].disabled
    equal "Comment", submit.text()

  asyncTest "submit input with default value is disabled and enabled on remote form", 5, ->
    form = @$("<form data-remote action='/echo?callback=formSubmitted' method=post><input type=submit data-disable-with='Submitting...'></form>").appendTo('body')

    submit = form.find('input[type=submit]')

    @window.formSubmitted = ->
      setTimeout ->
        ok !submit[0].disabled
        equal "Submit", submit.val()
        start()
      , 0

    equal "", submit.val()
    click submit[0]
    ok submit[0].disabled
    equal "Submitting...", submit.val()

  asyncTest "submit input is disabled and enabled on remote form", 5, ->
    form = @$("<form data-remote action='/echo?callback=formSubmitted' method=post><input type=submit value='Comment' data-disable-with='Commenting...'></form>").appendTo('body')

    submit = form.find('input[type=submit]')

    @window.formSubmitted = ->
      setTimeout ->
        ok !submit[0].disabled
        equal "Comment", submit.val()
        start()
      , 0

    equal "Comment", submit.val()
    click submit[0]
    ok submit[0].disabled
    equal "Commenting...", submit.val()

  asyncTest "submit button is disabled and enabled on remote form", 5, ->
    form = @$("<form data-remote action='/echo?callback=formSubmitted' method=post><button type=submit data-disable-with='Commenting...'>Comment</button></form>").appendTo('body')

    submit = form.find('button[type=submit]')

    @window.formSubmitted = ->
      setTimeout ->
        ok !submit[0].disabled
        equal "Comment", submit.text()
        start()
      , 0

    equal "Comment", submit.text()
    click submit[0]
    ok submit[0].disabled
    equal "Commenting...", submit.text()
