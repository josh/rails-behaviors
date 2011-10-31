$ ->
  fixture = $('#qunit-fixture')

  linkClicked = null
  window.clickLink = ->
    linkClicked = true
    return

  module "Confirm"
    setup: ->
      linkClicked = null

    teardown: ->
      delete window.confirm

      $(document).undelegate '.test'
      $('#qunit-fixture').html ""

  asyncTest "run default action if confirm returns true", ->
    window.confirm = -> true

    link = $("<a data-confirm='Are you sure?' href='javascript:clickLink();'>")
    fixture.append link

    link.trigger 'click'

    setTimeout ->
      ok linkClicked

      start()
    , 50

  asyncTest "doesn't run default action if confirm returns false", ->
    window.confirm = -> false

    link = $("<a data-confirm='Are you sure?' href='javascript:clickLink();'>")
    fixture.append link

    link.trigger 'click'

    setTimeout ->
      ok !linkClicked

      start()
    , 50

  test "runs other handlers action if confirm returns true", ->
    window.confirm = -> true

    link = $("<a data-confirm='Are you sure?' href='javascript:void(0);'>")
    fixture.append link

    handlerCalled = false
    $(document).delegate 'a', 'click.test', ->
      handlerCalled = true

    link.trigger 'click'
    ok handlerCalled

  test "doesn't run other handlers action if confirm returns false", ->
    window.confirm = -> false

    link = $("<a data-confirm='Are you sure?' href='javascript:void(0);'>")
    fixture.append link

    handlerCalled = false
    $(document).delegate 'a', 'click.test', ->
      handlerCalled = true

    link.trigger 'click'
    ok !handlerCalled
