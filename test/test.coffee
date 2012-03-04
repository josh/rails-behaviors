#= require qunit
#= require rails
#= require_directory ./unit

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
