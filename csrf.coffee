# CSRF
#
#= require ./beforesend
#= require ./prepare
#
# Adds CSRF tokens to AJAX requests and forms missing them.
#
# CSRF tokens must be set in the document head as meta tags.
#
#     <meta name="csrf-param" content="authenticity_token">
#     <meta name="csrf-token" content="5b404f7b7f90dc67708635fc8dd3">
#

# The AJAX prefilter filter will run before all jQuery XHR requests and
# allows the request to be modified.
$(document).on 'ajaxBeforeSend', (event, xhr, settings) ->
  # Skip for cross domain requests. Other sites can't do much
  # with our token.
  return if settings.crossDomain

  # Skip for GET requests
  return if settings.type is 'GET'

  # Get token from meta element on the page.
  #
  # On Rails 3, `<%= csrf_meta_tags %>` will spit this out.
  if token = $('meta[name="csrf-token"]').attr 'content'
    # Send the token along in a header.
    xhr.setRequestHeader 'X-CSRF-Token', token

# Listen for form submissions and inject hidden `authenticity_token`
# input into forms missing them.
$(document).on 'submit:prepare', 'form', ->
  form = $(this)

  # Don't handle remote requests. They'll have a header set instead.
  return if form.is 'form[data-remote]'

  # Skip for GET requests
  return if !this.method or this.method.toUpperCase() is 'GET'

  # Skip for cross domain requests. Other sites can't do much
  # with our token.
  return unless isSameOrigin form.attr 'action'

  # Get param token from meta elements on the page.
  #
  # On Rails 3, `<%= csrf_meta_tags %>` will spit these out.
  param = $('meta[name="csrf-param"]').attr 'content'
  token = $('meta[name="csrf-token"]').attr 'content'

  if param? and token?
    # Check if theres already a `authenticity_token` input field
    unless form.find("input[name=#{param}]")[0]
      input = document.createElement 'input'
      input.setAttribute 'type', 'hidden'
      input.setAttribute 'name', param
      input.setAttribute 'value', token
      form.prepend input

  return

origin = document.createElement 'a'
origin.href = location.href

# Check if url is within the same origin policy.
isSameOrigin = (url) ->
  a = document.createElement 'a'
  a.href = url
  a.href = a.href

  # Make sure that the browser parses the URL.
  a.protocol && a.host &&

  # Make sure that the protocols and hosts match.
  "#{origin.protocol}//#{origin.host}" == "#{a.protocol}//#{a.host}"
