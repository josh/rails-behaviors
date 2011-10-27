$(document).delegate 'a[data-confirm]', 'click', (event) ->
  if message = $(this).attr 'data-confirm'
    unless confirm message
      event.stopImmediatePropagation()
      return false

  return
