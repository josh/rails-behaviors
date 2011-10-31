$ ->
  fixture = $('#qunit-fixture')

  window.formSubmitted = ->

  module "Disable"
    setup: ->
      window.formSubmitted = ->

    teardown: ->
      $(document).undelegate '.test'
      $('#qunit-fixture').html ""

  asyncTest "submit input with default value is disabled", ->
    form = $("<form action='/echo?iframe=1&callback=formSubmitted' method=post><input type=submit data-disable-with='Submitting...'></form>")
    fixture.append form

    submit = $(form).find('input[type=submit]')

    window.formSubmitted = ->
      start()

    equal "", submit.val()
    submit.trigger 'click'
    ok submit[0].disabled
    equal "Submitting...", submit.val()

  asyncTest "submit input is disabled", ->
    form = $("<form action='/echo?iframe=1&callback=formSubmitted' method=post><input type=submit value='Comment' data-disable-with='Commenting...'></form>")
    fixture.append form

    submit = $(form).find('input[type=submit]')

    window.formSubmitted = ->
      start()

    equal "Comment", submit.val()
    submit.trigger 'click'
    ok submit[0].disabled
    equal "Commenting...", submit.val()

  asyncTest "submit input is disabled with default text", ->
    form = $("<form action='/echo?iframe=1&callback=formSubmitted' method=post><input type=submit value='Comment' data-disable-with></form>")
    fixture.append form

    submit = $(form).find('input[type=submit]')

    window.formSubmitted = ->
      start()

    equal "Comment", submit.val()
    submit.trigger 'click'
    ok submit[0].disabled
    equal "Comment", submit.val()

  asyncTest "submit button is disabled", ->
    form = $("<form action='/echo?iframe=1&callback=formSubmitted' method=post><button type=submit data-disable-with='Commenting...'>Comment</button></form>")
    fixture.append form

    submit = $(form).find('button[type=submit]')

    window.formSubmitted = ->
      start()

    equal "Comment", submit.text()
    submit.trigger 'click'
    ok submit[0].disabled
    equal "Commenting...", submit.text()


  asyncTest "submit button is disabled with default text", ->
    form = $("<form action='/echo?iframe=1&callback=formSubmitted' method=post><button type=submit data-disable-with>Comment</button></form>")
    fixture.append form

    submit = $(form).find('button[type=submit]')

    window.formSubmitted = ->
      start()

    equal "Comment", submit.text()
    submit.trigger 'click'
    ok submit[0].disabled
    equal "Comment", submit.text()

  asyncTest "submit input with default value is disabled and enabled on remote form", ->
    form = $("<form data-remote action='/echo?callback=formSubmitted' method=post><input type=submit data-disable-with='Submitting...'></form>")
    fixture.append form

    submit = $(form).find('input[type=submit]')

    window.formSubmitted = ->
      setTimeout ->
        ok !submit[0].disabled
        equal "Submit", submit.val()
        start()
      , 0

    equal "", submit.val()
    submit.trigger 'click'
    ok submit[0].disabled
    equal "Submitting...", submit.val()

  asyncTest "submit input is disabled and enabled on remote form", ->
    form = $("<form data-remote action='/echo?callback=formSubmitted' method=post><input type=submit value='Comment' data-disable-with='Commenting...'></form>")
    fixture.append form

    submit = $(form).find('input[type=submit]')

    window.formSubmitted = ->
      setTimeout ->
        ok !submit[0].disabled
        equal "Comment", submit.val()
        start()
      , 0

    equal "Comment", submit.val()
    submit.trigger 'click'
    ok submit[0].disabled
    equal "Commenting...", submit.val()

  asyncTest "submit button is disabled and enabled on remote form", ->
    form = $("<form data-remote action='/echo?callback=formSubmitted' method=post><button type=submit data-disable-with='Commenting...'>Comment</button></form>")
    fixture.append form

    submit = $(form).find('button[type=submit]')

    window.formSubmitted = ->
      setTimeout ->
        ok !submit[0].disabled
        equal "Comment", submit.text()
        start()
      , 0

    equal "Comment", submit.text()
    submit.trigger 'click'
    ok submit[0].disabled
    equal "Commenting...", submit.text()
