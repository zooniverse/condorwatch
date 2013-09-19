ifTouch = (touch, notTouch) ->
  try
    document.createEvent 'TouchEvent'
    touch
  catch e
    notTouch

module.exports = ifTouch
