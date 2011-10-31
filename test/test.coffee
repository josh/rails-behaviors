#= require qunit
#= require rails
#= require_directory .

$(document).delegate 'a[href]', 'click', (event) ->
  return if event.defaultPrevented || event.isDefaultPrevented?()
  window.location = event.target.href
  return

# Target form submissions to iframe
guid = 1
$(document).bind 'submit', (event) ->
  return if event.defaultPrevented || event.isDefaultPrevented?()
  name   = "frame#{guid++}"
  iframe = $ "<iframe id=#{name} name=#{name}>"
  $(event.target).attr 'target', name
  $('#qunit-fixture').append iframe

if Zepto?
  $(document).bind 'ajaxSuccess', (event, xhr) ->
    if xhr.getResponseHeader('Content-Type') is 'application/javascript'
      eval xhr.responseText

if window.JHW
  failures = []

  QUnit.begin ->
    for element in ["header", "banner", "userAgent", "tests"]
      el = document.getElementById("qunit-#{element}")
      el.parentNode.removeChild el if el

  QUnit.testDone (result) ->
    if result.failed
      failure = "[#{result.module}] #{result.name} (#{result.failed}, #{result.passed}, #{result.total})"
      failures.push failure
      JHW.specFailed failure
    else
      JHW.specPassed()

  QUnit.done (results) ->
    if failures.length
      JHW.printResult '' # force newline
      JHW.printResult failure for failure in failures
    JHW.finishSuite results.runtime/1000, results.total, results.failed
