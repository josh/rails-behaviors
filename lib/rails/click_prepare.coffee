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
  window.addEventListener 'click', (originalEvent) ->
    event = document.createEvent 'Events'
    event[k] = v for k, v of originalEvent
    event.initEvent 'click:prepare', true, true

    # Preventing prepared default stops the original event
    prevent = event.preventDefault
    event.preventDefault = ->
      originalEvent.preventDefault()
      prevent.apply this

    # Stopping propgation stops the original click phase
    stop = event.stopPropagation
    event.stopPropagation = ->
      originalEvent.stopPropagation()
      stop.apply this

    # Stopping immediate propgation stops the original click phase
    stopImmediate = event.stopImmediatePropagation
    event.stopImmediatePropagation = ->
      originalEvent.stopImmediatePropagation()
      stopImmediate.apply this

    originalEvent.target.dispatchEvent event
    event.result

  , true

else
  lastPreparedTimestamp = null

  # Hook into jQuery click event trigger
  $.event.special.click =
    # preDispatch is a new hook added in 1.7.2. Its not documented as
    # a real public API, but we'll abuse it anyway.
    preDispatch: (event) ->
      # Check if this event has dispatched a prepare event already
      if event.timeStamp isnt lastPreparedTimestamp
        # Reuse the existing event instead of creating a new copy. Any
        # calls to preventDefault or stopPropagation will take
        # immediate effect.
        event.type = 'click:prepare'
        $.event.trigger event, [], event.target, false
        # Restore the old event type
        event.type = 'click'
        # Mark event's timestamp id as prepared
        lastPreparedTimestamp = event.timeStamp
      return
