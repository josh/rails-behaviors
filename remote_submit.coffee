# Emulates submit button submission values for AJAX forms
#
# For regular form submissions, the name and value of the clicked
# submit button is passed along in the params. The key and value is
# typically something like `submit=Comment`. This is almost never used
# when there is only one button.
#
# When there are two buttons, the input names are different to
# indicate which button was pressed. One value might be `comment` and
# the other `cancel`.
#
# For AJAX form submissions this value isn't recorded
# anywhere. jQuery's `$.serialize` only returns the params for inputs
# that are on the page.
#
# We can work around this by inserting a dummy input on 'click' so
# jQuery can send it along to the server.
#
# This workaround only needs to happen on AJAX forms, so `data-remote`
# or `data-remote-submit` must be set on the form to enable it.

submitSelectors = """
  form[data-remote] input[type=submit],
  form[data-remote] button[type=submit],
  form[data-remote] button:not([type]),
  form[data-remote-submit] input[type=submit],
  form[data-remote-submit] button[type=submit],
  form[data-remote-submit] button:not([type])
"""

# Listen for all submit buttons clicks that bubble up to the doucment.
$(document).on 'click', submitSelectors, ->
  submit = $(this)
  form   = submit.closest 'form'
  input  = form.find '.js-submit-button-value'

  if name = submit.attr 'name'
    # Get value of submit button.
    # Input submit fields have a default value of 'Submit'
    # Buttons defaults to ''
    defaultValue = if submit.is 'input[type=submit]' then 'Submit' else ''
    value = submit.val() or defaultValue

    if not input[0]
      # Insert a dummy input so $.fn.serialize picks up the value
      input = document.createElement 'input'
      input.setAttribute 'type', 'hidden'
      input.setAttribute 'name', name
      input.setAttribute 'value', value
      input.setAttribute 'class', 'js-submit-button-value'
      form.prepend input
    else
      # A hidden input already exists in the form, we can just
      # update the value.
      input.attr 'name', name
      input.attr 'value', value
  else
    # Submit button has no name, remove any hidden inputs so no
    # value is submitted.
    input.remove()

  return
