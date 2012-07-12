each frameworks, (framework) ->
  module "#{framework} - prepare",
    setup: ->
      setupFrame this, "/#{framework}.html"
      window.formSubmitted = ->

    teardown: ->
      delete window.formSubmitted

  asyncTest "click:prepare events run before others", 4, ->
    link = @$("<a href='#'>Click</a>").appendTo('body')

    count = 0

    link.on 'click', ->
      equal ++count, 3

    link.on 'click:prepare', ->
      equal ++count, 1

    link.on 'click', ->
      equal ++count, 4

    link.on 'click:prepare', ->
      equal ++count, 2

    click link[0]

    start()

  asyncTest "click:prepare event can prevent default", 1, ->
    link = @$("<a href='#'>Click</a>").appendTo('body')

    link.on 'click:prepare', (event) ->
      event.preventDefault()

    link.on 'click', (event) ->
      ok event.defaultPrevented or event.isDefaultPrevented()

    click link[0]

    start()

  asyncTest "click:prepare event can stop propagation", 1, ->
    link = @$("<a href='#'>Click</a>").appendTo('body')

    link.on 'click:prepare', (event) ->
      event.stopPropagation()
      ok true

    link.on 'click', (event) ->
      ok false

    click link[0]

    start()


  asyncTest "submit:prepare events run before others", 4, ->
    form = @$("<form action='/echo?iframe=1&callback=formSubmitted' method=post></form>").appendTo('body')

    count = 0

    form.on 'submit', ->
      equal ++count, 3

    form.on 'submit:prepare', ->
      equal ++count, 1

    form.on 'submit', ->
      equal ++count, 4

    form.on 'submit:prepare', ->
      equal ++count, 2

    form.submit()
    start()

  asyncTest "submit:prepare event can prevent default", 1, ->
    form = @$("<form action='/echo?iframe=1&callback=formSubmitted' method=post></form>").appendTo('body')

    form.on 'submit:prepare', (event) ->
      event.preventDefault()

    form.on 'submit', (event) ->
      ok event.defaultPrevented or event.isDefaultPrevented()

    form.submit()
    start()

  asyncTest "submit:prepare event can stop propagation", 1, ->
    form = @$("<form action='/echo?iframe=1&callback=formSubmitted' method=post></form>").appendTo('body')

    form.on 'submit:prepare', (event) ->
      event.stopPropagation()
      ok true

    form.on 'submit', (event) ->
      ok false

    form.submit()
    start()
