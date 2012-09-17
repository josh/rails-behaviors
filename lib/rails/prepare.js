(function() {
  var dispatchPrepare, lastPreparedTimestamp, preDispatch, setup, teardown;

  if (typeof Zepto !== "undefined" && Zepto !== null) {
    dispatchPrepare = function(originalEvent) {
      var combine, event, k, v;
      event = document.createEvent('Events');
      for (k in originalEvent) {
        v = originalEvent[k];
        event[k] = v;
      }
      event.initEvent("" + originalEvent.type + ":prepare", true, true);
      combine = function(f, g) {
        return function() {
          f.apply(originalEvent);
          return g.apply(event);
        };
      };
      event.preventDefault = combine(originalEvent.preventDefault, event.preventDefault);
      event.stopPropagation = combine(originalEvent.stopPropagation, event.stopPropagation);
      event.stopImmediatePropagation = combine(originalEvent.stopImmediatePropagation, event.stopImmediatePropagation);
      originalEvent.target.dispatchEvent(event);
      return event.result;
    };
    window.addEventListener('click', dispatchPrepare, true);
    window.addEventListener('submit', dispatchPrepare, true);
  } else {
    lastPreparedTimestamp = null;
    preDispatch = function(event) {
      var origType;
      if (event.timeStamp !== lastPreparedTimestamp) {
        origType = event.type;
        event.type = "" + origType + ":prepare";
        $.event.trigger(event, [], event.target, false);
        event.type = origType;
        lastPreparedTimestamp = event.timeStamp;
      }
    };
    setup = function(event) {
      return function() {
        $(this).on("" + event + ".prepare", function() {});
      };
    };
    teardown = function(event) {
      return function() {
        $(this).off("" + event + ".prepare", function() {});
      };
    };
    $.event.special.click = {
      preDispatch: preDispatch
    };
    $.event.special.submit = {
      preDispatch: preDispatch
    };
    $.event.special['click:prepare'] = {
      setup: setup('click'),
      teardown: teardown('click')
    };
    $.event.special['submit:prepare'] = {
      setup: setup('submit'),
      teardown: teardown('submit')
    };
  }

}).call(this);
