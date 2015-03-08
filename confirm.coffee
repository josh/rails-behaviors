# Confirm
#
#= require ./prepare
#
# Prompts native confirm dialog before activating link.
#
# ### Markup
#
# `<a>`
#
# ``` definition-table
# Attribute - Description
#
# `data-confirm` - Message to pass to `confirm()`.
# ```
#
# ``` html
# <a href="/" data-confirm="Are you sure?">Delete</a>
# ```
#
# `<button>`
#
# ``` definition-table
# Attribute - Description
#
# `data-confirm` - Message to pass to `confirm()`.
# ```
#
# ``` html
# <button type="submit" data-confirm="Are you sure?">Delete</a>
# ```

$(document).on 'click:prepare', 'a[data-confirm], input[type=submit][data-confirm], button[data-confirm]', (event) ->
  if message = $(this).attr 'data-confirm'
    # Prompt message with native confirm dialog
    unless confirm message
      # Prevent other handlers on the document from running
      event.stopImmediatePropagation()
      # Prevent default action from running
      event.preventDefault()
  return
