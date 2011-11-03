$ ->
  module "Accept"

  asyncTest "default accept header prefers scripts", ->
    $.ajax
      type: 'POST'
      url: "/echo"
      success: (env) ->
        equal  "*/*;q=0.5, text/javascript, application/javascript, application/ecmascript, application/x-ecmascript", env['HTTP_ACCEPT']
        start()

  asyncTest "dataType overrides defautl accept header", ->
    $.ajax
      type: 'POST'
      url: "/echo"
      dataType: 'json'
      success: (env) ->
        equal  "application/json, text/javascript, */*; q=0.01", env['HTTP_ACCEPT']
        start()
