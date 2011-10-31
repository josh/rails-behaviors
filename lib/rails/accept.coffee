#= require ./beforesend

$(document).bind 'ajaxBeforeSend', (event, xhr, settings) ->
  unless settings.dataType
    xhr.setRequestHeader 'Accept', '*/*;q=0.5, ' + settings.accepts.script
