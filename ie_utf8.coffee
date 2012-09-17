# Old IE UTF-8 Fix
#
#= require ./prepare
#
# Targets IE 8 and below.
#
# Inserts a hidden field with a UTF-8 character to force the forms
# encoding to be UTF-8 regardless of the browsers encoding setting.
#
# See http://intertwingly.net/blog/2010/07/29/Rails-and-Snowmen
if (m = navigator.userAgent.match /MSIE ([\w]+)/) and parseInt(m[1]) <= 8
  $(document).on 'submit:prepare', 'form', ->
    if $(this).find('input[name=utf8]').length is 0
      $(this).prepend '<input type=hidden name=utf8 value=✓>'
      return
