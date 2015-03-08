each frameworks, (framework) ->
  module "#{framework} - Confirm",
    setup: ->
      setupFrame this, "/#{framework}.html"

  test "run default action if confirm returns true", 2, ->
    @window.confirm = (message) ->
      equal message, "Are you sure?"
      true

    @window.clickLink = ->
      ok true

    link = @$("<a data-confirm='Are you sure?' href='javascript:clickLink();'>")[0]
    @document.body.appendChild link

    click link

  test "doesn't run default action if confirm returns false", 1, ->
    @window.confirm = (message) ->
      equal message, "Are you sure?"
      false

    @window.clickLink = ->
      ok false

    link = @$("<a data-confirm='Are you sure?' href='javascript:clickLink();'>")[0]
    @document.body.appendChild link

    click link

  test "runs other handlers action if confirm returns true", 2, ->
    @window.confirm = (message) ->
      equal message, "Are you sure?"
      true

    link = @$("<a data-confirm='Are you sure?' href='javascript:void(0);'>")[0]
    @document.body.appendChild link

    @$(@document).on 'click.test', 'a', ->
      ok true

    click link

  test "doesn't run other handlers action if confirm returns false", 1, ->
    @window.confirm = (message) ->
      equal message, "Are you sure?"
      false

    link = @$("<a data-confirm='Are you sure?' href='javascript:void(0);'>")[0]
    @document.body.appendChild link

    @$(@document).on 'click.test', 'a', ->
      ok false

    click link

  test "submit form if <button> confirm returns true", 2, ->
    @window.confirm = (message) ->
      equal message, "Are you sure?"
      true

    @$("<form><button data-confirm='Are you sure?'></form>").appendTo(@document.body)

    @$(@document).on 'submit.test', ->
      ok true
      false

    click @$("button")[0]

  test "cancel form submit if <button> confirm returns false", 1, ->
    @window.confirm = (message) ->
      equal message, "Are you sure?"
      false

    @$("<form><button data-confirm='Are you sure?'></form>").appendTo(@document.body)

    @$(@document).on 'submit.test', ->
      ok false
      false

    click @$("button")[0]

  test "submit form if <input type=submit> confirm returns true", 2, ->
    @window.confirm = (message) ->
      equal message, "Are you sure?"
      true

    @$("<form><input type=submit data-confirm='Are you sure?'></form>").appendTo(@document.body)

    @$(@document).on 'submit.test', ->
      ok true
      false

    click @$("input[type=submit]")[0]

  test "cancel form submit if <input type=submit> confirm returns false", 1, ->
    @window.confirm = (message) ->
      equal message, "Are you sure?"
      false

    @$("<form><input type=submit data-confirm='Are you sure?'></form>").appendTo(@document.body)

    @$(@document).on 'submit.test', ->
      ok false
      false

    click @$("input[type=submit]")[0]
