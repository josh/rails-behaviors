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

    submit = $(form).find('input[type=submit]')[0]

    window.formSubmitted = ->
      start()

    equal "", submit.value
    submit.click()
    ok submit.disabled
    equal "Submitting...", submit.value

  asyncTest "submit input is disabled", ->
    form = $("<form action='/echo?iframe=1&callback=formSubmitted' method=post><input type=submit value='Comment' data-disable-with='Commenting...'></form>")
    fixture.append form

    submit = $(form).find('input[type=submit]')[0]

    window.formSubmitted = ->
      start()

    equal "Comment", submit.value
    submit.click()
    ok submit.disabled
    equal "Commenting...", submit.value

  asyncTest "submit input is disabled with default text", ->
    form = $("<form action='/echo?iframe=1&callback=formSubmitted' method=post><input type=submit value='Comment' data-disable-with></form>")
    fixture.append form

    submit = $(form).find('input[type=submit]')[0]

    window.formSubmitted = ->
      start()

    equal "Comment", submit.value
    submit.click()
    ok submit.disabled
    equal "Comment", submit.value

  asyncTest "submit button is disabled", ->
    form = $("<form action='/echo?iframe=1&callback=formSubmitted' method=post><button type=submit data-disable-with='Commenting...'>Comment</button></form>")
    fixture.append form

    submit = $(form).find('button[type=submit]')[0]

    window.formSubmitted = ->
      start()

    equal "Comment", submit.innerHTML
    submit.click()
    ok submit.disabled
    equal "Commenting...", submit.innerHTML


  asyncTest "submit button is disabled with default text", ->
    form = $("<form action='/echo?iframe=1&callback=formSubmitted' method=post><button type=submit data-disable-with>Comment</button></form>")
    fixture.append form

    submit = $(form).find('button[type=submit]')[0]

    window.formSubmitted = ->
      start()

    equal "Comment", submit.innerHTML
    submit.click()
    ok submit.disabled
    equal "Comment", submit.innerHTML

  asyncTest "submit input with default value is disabled and enabled on remote form", ->
    form = $("<form data-remote action='/echo?callback=formSubmitted' method=post><input type=submit data-disable-with='Submitting...'></form>")
    fixture.append form

    submit = $(form).find('input[type=submit]')[0]

    window.formSubmitted = ->
      setTimeout ->
        ok !submit.disabled
        # equal "Submit", submit.value
        start()
      , 0

    equal "", submit.value
    submit.click()
    ok submit.disabled
    # equal "Submitting...", submit.value

  asyncTest "submit input is disabled and enabled on remote form", ->
    form = $("<form data-remote action='/echo?callback=formSubmitted' method=post><input type=submit value='Comment' data-disable-with='Commenting...'></form>")
    fixture.append form

    submit = $(form).find('input[type=submit]')[0]

    window.formSubmitted = ->
      setTimeout ->
        ok !submit.disabled
        equal "Comment", submit.value
        start()
      , 0

    equal "Comment", submit.value
    submit.click()
    ok submit.disabled
    equal "Commenting...", submit.value

  asyncTest "submit button is disabled and enabled on remote form", ->
    form = $("<form data-remote action='/echo?callback=formSubmitted' method=post><button type=submit data-disable-with='Commenting...'>Comment</button></form>")
    fixture.append form

    submit = $(form).find('button[type=submit]')[0]

    window.formSubmitted = ->
      setTimeout ->
        ok !submit.disabled
        equal "Comment", submit.innerHTML
        start()
      , 0

    equal "Comment", submit.innerHTML
    submit.click()
    ok submit.disabled
    equal "Commenting...", submit.innerHTML
