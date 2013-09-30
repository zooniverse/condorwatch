ifTouch = (touch, notTouch) ->
  if 'ontouchstart' of document.body
    touch
  else
    notTouch

module.exports = ifTouch
