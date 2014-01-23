# click:prepare event
#
# This event is psuedo click capture event that event works in
# browsers without DOM Level 3 events. The prepare event is always
# fired before any other click handlers are ran. Calling
# stopPropagation or returning false will prevent the other handlers.
#
# Eventually, if jQuery 2 moves to the standard event and dispatch
# model, all this can go away and we'll just use capture as intended.

if Zepto?
  # All browsers that support Zepto have addEventListener, we can just
  # use native capture here.
  dispatchPrepare = (originalEvent) ->
    event = document.createEvent 'Events'
    event[k] = v for k, v of originalEvent
    event.initEvent "#{originalEvent.type}:prepare", true, true

    # Forward event calls back to originalEvent
    combine = (f, g) -> -> f.apply originalEvent; g.apply event
    event.preventDefault = combine originalEvent.preventDefault, event.preventDefault
    event.stopPropagation = combine originalEvent.stopPropagation, event.stopPropagation
    event.stopImmediatePropagation = combine originalEvent.stopImmediatePropagation, event.stopImmediatePropagation

    originalEvent.target.dispatchEvent event
    event.result

  window.addEventListener 'click', dispatchPrepare, true
  window.addEventListener 'submit', dispatchPrepare, true

else
  # Keep track of last prepared event timestamp. It serves as a unique
  # to check against in each events dispatch handler.
  lastPreparedTimestamp = null

  # preDispatch is a new hook added in 1.7.2. Its not documented as
  # a real public API, but we'll abuse it anyway.
  preDispatch = (event) ->
    timestamp = "#{event.type}:" + event.timeStamp
    # Check if this event has dispatched a prepare event already
    if timestamp isnt lastPreparedTimestamp
      # Reuse the existing event instead of creating a new copy. Any
      # calls to preventDefault or stopPropagation will take
      # immediate effect.
      origType = event.type
      event.type = "#{origType}:prepare"
      $.event.trigger event, [], event.target, false
      # Restore the old event type
      event.type = origType
      # Mark event's timestamp id as prepared
      lastPreparedTimestamp = timestamp
    return

  # Install stub prepare handler to ensure preDispatch is invoked
  setup = (event) -> ->
    $(this).on "#{event}.prepare", ->
    return

  # Uninstall stub prepare handler to keep things tidy
  teardown = (event) -> ->
    $(this).off "#{event}.prepare", ->
    return

  # Install preDispatch handlers into click and submit
  $.event.special.click = {preDispatch}
  $.event.special.submit = {preDispatch}

  # Install stub handlers when someone is listening to prepare events
  $.event.special['click:prepare'] = setup: setup('click'), teardown: teardown('click')
  $.event.special['submit:prepare'] = setup: setup('submit'), teardown: teardown('submit')
