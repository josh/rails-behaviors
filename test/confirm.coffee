$ ->
  module "Confirm"

  linkClicked = null
  window.clickLink = ->
    linkClicked = true
    return

  asyncTest "run default action if confirm returns true", ->
    linkClicked = null

    window.confirm = -> true
    link = $("<a data-confirm='Are you sure?' href='javascript:clickLink();'>")[0]
    document.body.appendChild link

    link.click()

    setTimeout ->
      ok linkClicked

      $(link).remove()
      delete window.confirm

      start()
    , 50

  asyncTest "doesn't run default action if confirm returns false", ->
    linkClicked = null

    window.confirm = -> false
    link = $("<a data-confirm='Are you sure?' href='javascript:clickLink();'>")[0]
    document.body.appendChild link

    link.click()

    setTimeout ->
      ok !linkClicked

      $(link).remove()
      delete window.confirm

      start()
    , 50

  test "runs other handlers action if confirm returns true", ->
    window.confirm = -> true
    link = $("<a data-confirm='Are you sure?' href='javascript:void(0);'>")[0]
    document.body.appendChild link
    handlerCalled = false
    $(document).delegate 'a', 'click.test', ->
      handlerCalled = true

    link.click()
    ok handlerCalled

    $(document).undelegate 'click.test'
    $(link).remove()
    delete window.confirm

  test "doesn't run other handlers action if confirm returns false", ->
    window.confirm = -> false
    link = $("<a data-confirm='Are you sure?' href='javascript:void(0);'>")[0]
    document.body.appendChild link
    handlerCalled = false
    $(document).delegate 'a', 'click.test', ->
      handlerCalled = true

    link.click()
    ok !handlerCalled

    $(document).undelegate 'click.test'
    $(link).remove()
    delete window.confirm
