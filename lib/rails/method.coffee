# Method
#
# Allow links to be followed with an alternate method
# using `data-method`.
#
# To fake this, a hidden form element is created on the fly
# and is submitted.
#
# ### Markup
#
# `<a>`
#
# ``` definition-table
# Attribute - Description
#
# `data-method`
#   Method for following `href`. Can be `"post"`, `"put"`, or
#   `"delete"`. `"get"` is ignored since its the default behavior for
#   links.
# ```
#
#     <a href="/posts/1" data-method="delete">Delete</a>

$(document).on 'click', 'a[data-method]', (event) ->
  element = $(this)

  # Don't handle remote requests
  return if element.is 'a[data-remote]'

  method = element.attr('data-method').toLowerCase()

  # Skip GET requests
  return if method is 'get'

  # Create a dummy form
  form = document.createElement 'form'
  form.method = 'POST'
  form.action = element.attr 'href'
  form.style.display = 'none'

  # Set `_method` to simulate other methods like PUT and DELETE.
  if method isnt 'post'
    input = document.createElement 'input'
    input.setAttribute 'type', 'hidden'
    input.setAttribute 'name', '_method'
    input.setAttribute 'value', method
    form.appendChild input

  # Add it to the document and fire it off
  document.body.appendChild form
  $(form).submit()

  # Prevent default action so we don't follow the link
  event.preventDefault()
  false
