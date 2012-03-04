module "Confirm"
  setup: ->
    setupFrame this, "/frame"

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

  link = $("<a data-confirm='Are you sure?' href='javascript:clickLink();'>")[0]
  @document.body.appendChild link

  click link

test "runs other handlers action if confirm returns true", 2, ->
  @window.confirm = ->
    ok true
    true

  link = $("<a data-confirm='Are you sure?' href='javascript:void(0);'>")[0]
  @document.body.appendChild link

  @$(@document).delegate 'a', 'click.test', ->
    ok true

  click link

test "doesn't run other handlers action if confirm returns false", 1, ->
  @window.confirm = ->
    ok true
    false

  link = $("<a data-confirm='Are you sure?' href='javascript:void(0);'>")[0]
  @document.body.appendChild link

  @$(@document).delegate 'a', 'click.test', ->
    ok false

  click link
