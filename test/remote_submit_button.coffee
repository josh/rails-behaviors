$ ->
  fixture = $('#qunit-fixture')

  window.formSubmitted = ->

  module "Remote Submit Button"
    setup: ->
      window.formSubmitted = ->

    teardown: ->
      $(document).undelegate '.test'
      $('#qunit-fixture').html ""

  asyncTest "form submit button value is serialized", ->
    form = $("<form data-remote action='/echo?callback=formSubmitted'><button type=submit name=submit>Submit</button></form>")
    fixture.append form

    window.formSubmitted = (data) ->
      equal data.params['submit'], ""
      start()

    $(form).find('button[name=submit]').trigger 'click'

  asyncTest "form submit comment button value is serialized", ->
    form = $("<form data-remote action='/echo?callback=formSubmitted'><button type=submit name=submit value=comment>Comment</button><button type=submit name=submit value=cancel>Cancel</button></form>")
    fixture.append form

    window.formSubmitted = (data) ->
      equal data.params['submit'], "comment"
      start()

    $(form).find('button[name=submit][value=comment]').trigger 'click'

  asyncTest "form submit cancel button value is serialized", ->
    form = $("<form data-remote action='/echo?callback=formSubmitted'><button type=submit name=submit value=comment>Comment</button><button type=submit name=submit value=cancel>Cancel</button></form>")
    fixture.append form

    window.formSubmitted = (data) ->
      equal data.params['submit'], "cancel"
      start()

    $(form).find('button[name=submit][value=cancel]').trigger 'click'
