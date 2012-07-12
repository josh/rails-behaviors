each frameworks, (framework) ->
  module "#{framework} - click:prepare",
    setup: ->
      setupFrame this, "/#{framework}.html"

  asyncTest "prepare events run before others", 4, ->
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

  asyncTest "prepare event can prevent default", 1, ->
    link = @$("<a href='#'>Click</a>").appendTo('body')

    count = 0

    link.on 'click:prepare', (event) ->
      event.preventDefault()

    link.on 'click', (event) ->
      ok event.defaultPrevented or event.isDefaultPrevented()

    click link[0]

    start()

  asyncTest "prepare event can stop propagation", 1, ->
    link = @$("<a href='#'>Click</a>").appendTo('body')

    count = 0

    link.on 'click:prepare', (event) ->
      event.stopPropagation()
      ok true

    link.on 'click', (event) ->
      ok false

    click link[0]

    start()
