$(document).on 'click', 'a[data-confirm]', (event) ->
  if message = $(this).attr 'data-confirm'
    unless confirm message
      event.stopImmediatePropagation()
      return false

  return
