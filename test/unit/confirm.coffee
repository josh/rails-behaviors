each frameworks, (framework) ->
  module "#{framework} - Confirm",
    setup: ->
      setupFrame this, "/#{framework}.html"

  test "run default action if confirm returns true", 2, ->
    @window.confirm = ->
      ok true
      true

    @window.clickLink = ->
      ok true

    link = @$("<a data-confirm='Are you sure?' href='javascript:clickLink();'>")[0]
    @document.body.appendChild link

    click link

  test "doesn't run default action if confirm returns false", 1, ->
    @window.confirm = ->
      ok true
      false

    @window.clickLink = ->
      ok false

    link = @$("<a data-confirm='Are you sure?' href='javascript:clickLink();'>")[0]
    @document.body.appendChild link

    click link

  test "runs other handlers action if confirm returns true", 2, ->
    @window.confirm = ->
      ok true
      true

    link = @$("<a data-confirm='Are you sure?' href='javascript:void(0);'>")[0]
    @document.body.appendChild link

    @$(@document).on 'click.test', 'a', ->
      ok true

    click link

  test "doesn't run other handlers action if confirm returns false", 1, ->
    @window.confirm = ->
      ok true
      false

    link = @$("<a data-confirm='Are you sure?' href='javascript:void(0);'>")[0]
    @document.body.appendChild link

    @$(@document).on 'click.test', 'a', ->
      ok false

    click link

  test "works with <button> elements as well", 1, ->
    @window.confirm = ->
      ok true
      true

    @window.clickLink = ->
      ok true

    button = @$("<button type='button' data-confirm='Are you sure?'>")[0]
    @document.body.appendChild button

    click button
