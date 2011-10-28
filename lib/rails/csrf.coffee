# Adds CSRF tokens to AJAX requests and forms missing them.
#
# CSRF tokens must be set in the document head as meta tags.
#
#     <meta name="csrf-param" content="authenticity_token">
#     <meta name="csrf-token" content="5b404f7b7f90dc67708635fc8dd3">
#

# The AJAX prefilter filter will run before all jQuery XHR requests and
# allows the request to be modified.
$.ajaxPrefilter (options, originalOptions, xhr) ->
  # Skip for cross domain requests. Other sites can't do much
  # with our token.
  return if options.crossDomain

  # Get token from meta element on the page.
  #
  # On Rails 3, `<%= csrf_meta_tags %>` will spit this out.
  if token = $('meta[name="csrf-token"]').attr 'content'
    # Send the token along in a header.
    xhr.setRequestHeader 'X-CSRF-Token', token

# Listen for form submissions and inject hidden `authenticity_token`
# input into forms missing them.
$(document).delegate 'form', 'submit', (event) ->
  form = $(this)

  # Don't handle remote requests. They'll have a header set instead.
  return if form.is 'form[data-remote]'

  # Get param token from meta elements on the page.
  #
  # On Rails 3, `<%= csrf_meta_tags %>` will spit these out.
  param = $('meta[name="csrf-param"]').attr 'content'
  token = $('meta[name="csrf-token"]').attr 'content'

  if param? and token?
    # Check if theres already a `authenticity_token` input field
    unless form.find("input[name=#{param}]")[0]
      form.prepend "<input type='hidden' name='#{param}' value='#{token}'>"

  # Return `undefined` so we don't stop the event propagation.
  return
