module "Remote Submit Button"
  setup: ->
    setupFrame this, "/frame"

asyncTest "form submit button value is serialized", 1, ->
  form = @$("<form data-remote action='/echo?callback=formSubmitted'><button type=submit name=submit>Submit</button></form>").appendTo('body')

  @window.formSubmitted = (data) ->
    equal data.params['submit'], ""
    start()

  click form.find('button[name=submit]')[0]

asyncTest "form submit comment button value is serialized", 1, ->
  form = @$("<form data-remote action='/echo?callback=formSubmitted'><button type=submit name=submit value=comment>Comment</button><button type=submit name=submit value=cancel>Cancel</button></form>").appendTo('body')

  @window.formSubmitted = (data) ->
    equal data.params['submit'], "comment"
    start()

  click form.find('button[name=submit][value=comment]')[0]

asyncTest "form submit cancel button value is serialized", 1, ->
  form = @$("<form data-remote action='/echo?callback=formSubmitted'><button type=submit name=submit value=comment>Comment</button><button type=submit name=submit value=cancel>Cancel</button></form>").appendTo('body')

  @window.formSubmitted = (data) ->
    equal data.params['submit'], "cancel"
    start()

  click form.find('button[name=submit][value=cancel]')[0]

test "form submit button value is serialized for data-remote-submit", 1, ->
  form = @$("<form data-remote-submit action='/echo?callback=formSubmitted'><button type=submit name=submit value=comment>Comment</button><button type=submit name=submit value=cancel>Cancel</button></form>").appendTo('body')

  form.bind 'submit', ->
    equal form.serialize(), "submit=comment"
    false

  click form.find('button[name=submit][value=comment]')[0]
