# Disables clicked buttons with text in `data-disable-with`.
#
#     <input type="submit" data-disable-with="Submitting...">

$(document).delegate 'form', 'submit', ->
  for input in $(this).find 'input[type=submit][data-disable-with]'
    input = $ input
    # Get current value, default to 'Submit' text otherwise
    input.attr 'data-enable-with', input.val() or 'Submit'
    # If the text is empty, don't change anything
    if value = input.attr 'data-disable-with'
      input.val value
    input.prop 'disabled', true

  for button in $(this).find 'button[type=submit][data-disable-with]'
    button = $ button
    # Get button text, default to '' text otherwise
    button.attr 'data-enable-with', button.text() or ''
    # If the text is empty, don't change anything
    if value = button.attr 'data-disable-with'
      button.text value
    button.prop 'disabled', true

  # Return `undefined` so we don't stop the event propagation.
  return

# Renable controls when AJAX request finishes
$(document).delegate 'form', 'ajaxComplete', ->
  # Find all submit inputs to re-enable
  for input in $(this).find 'input[type=submit][data-enable-with]'
    input = $ input
    input.val input.attr 'data-enable-with'
    input.prop 'disabled', false

  # Find submit buttons to re-enable
  for button in $(this).find 'button[type=submit][data-enable-with]'
    button = $ button
    button.text button.attr 'data-enable-with'
    button.prop 'disabled', false

  # Return `undefined` in case.
  return
