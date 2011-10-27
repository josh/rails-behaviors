$.ajaxPrefilter (options, originalOptions, xhr) ->
  return if options.crossDomain

  if token = $('meta[name="csrf-token"]').attr 'content'
    xhr.setRequestHeader 'X-CSRF-Token', token
