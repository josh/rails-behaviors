# Disable
#
#= require ./prepare
#
# Disables clicked buttons with text in `data-disable-with`.
#
# ### Markup
#
# `<input type=submit>` or `<button type=submit>`
#
# ``` definition-table
# Attribute - Description
#
# `data-disable-with` - Message to set `<input>` value or `<button>` innerHTML to.
# ```
#
#     <input type="submit" data-disable-with="Submitting...">

$(document).on 'submit:prepare', 'form', ->
  for input in $(this).find 'input[type=submit][data-disable-with]'
    input = $ input
    # Get current value, default to 'Submit' text otherwise
    input.attr 'data-enable-with', input.val() or 'Submit'
    # If the text is empty, don't change anything
    if value = input.attr 'data-disable-with'
      input.val value
    input[0].disabled = true

  for button in $(this).find 'button[type=submit][data-disable-with]'
    button = $ button
    # Get button text, default to '' text otherwise
    button.attr 'data-enable-with', button.html() or ''
    # If the text is empty, don't change anything
    if value = button.attr 'data-disable-with'
      button.html value
    button[0].disabled = true

  return

# Renable controls when AJAX request finishes
$(document).on 'ajaxComplete', 'form', ->
  # Find all submit inputs to re-enable
  for input in $(this).find 'input[type=submit][data-enable-with]'
    $(input).val $(input).attr 'data-enable-with'
    input.disabled = false

  # Find submit buttons to re-enable
  for button in $(this).find 'button[type=submit][data-enable-with]'
    $(button).html $(button).attr 'data-enable-with'
    button.disabled = false

  return
