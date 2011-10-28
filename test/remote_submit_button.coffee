$ ->
  module "Remote Submit Button"

  window.formSubmitted = ->

  asyncTest "form submit button value is serialized", ->
    expect 1

    form = $("<form data-remote action='/echo?callback=formSubmitted'><button type=submit name=submit>Submit</button></form>")[0]
    document.body.appendChild form

    window.formSubmitted = (data) ->
      equal "", data.params['submit']

      $(form).remove()
      window.formSubmitted = ->

      start()

    $(form).find('button[name=submit]')[0].click()

  asyncTest "form submit comment button value is serialized", ->
    expect 1

    form = $("<form data-remote action='/echo?callback=formSubmitted'><button type=submit name=submit value=comment>Comment</button><button type=submit name=submit value=cancel>Cancel</button></form>")[0]
    document.body.appendChild form

    window.formSubmitted = (data) ->
      equal "comment", data.params['submit']

      $(form).remove()
      window.formSubmitted = ->

      start()

    $(form).find('button[name=submit]')[0].click()

  asyncTest "form submit cancel button value is serialized", ->
    expect 1

    form = $("<form data-remote action='/echo?callback=formSubmitted'><button type=submit name=submit value=comment>Comment</button><button type=submit name=submit value=cancel>Cancel</button></form>")[0]
    document.body.appendChild form

    window.formSubmitted = (data) ->
      equal "cancel", data.params['submit']

      $(form).remove()
      window.formSubmitted = ->

      start()

    $(form).find('button[name=submit]')[1].click()
