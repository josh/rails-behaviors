# Prompt native confirm dialog for `data-confirm` links.
#
#     <a href="/" data-confirm="Are you sure?">Delete</a>

$(document).delegate 'a[data-confirm]', 'click', (event) ->
  if message = $(this).attr 'data-confirm'
    # Prompt message with native confirm dialog
    unless confirm message
      # Prevent other handlers on the document from running
      event.stopImmediatePropagation()
      # Prevent default action from running
      return false

  # Return `undefined` so we don't stop the event propagation.
  return
