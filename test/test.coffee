#= require jquery
#= require qunit
#= require rails
#= require_directory .

unless document.createElement('a').click
  # Simulate mouse clicks
  HTMLElement.prototype.click = ->
    event = @ownerDocument.createEvent 'MouseEvents'
    event.initMouseEvent 'click', true, true, @ownerDocument.defaultView, 1, 0, 0, 0, 0, false, false, false, false, 0, null
    @dispatchEvent event
    return

# Target form submissions to iframe
$(document).on 'submit', (event) ->
  unless event.isDefaultPrevented()
    name   = "frame#{jQuery.guid++}"
    iframe = $ "<iframe id=#{name} name=#{name}>"
    $(event.target).attr 'target', name
    $('#qunit-fixture').append iframe
