BaseController = require 'zooniverse/controllers/base-controller'
FauxRangeInput = require 'faux-range-input'

class IndividualImageReview extends BaseController
  image: ''
  marks: null
  index: NaN
  total: NaN

  className: 'individual-image'
  template: require '../views/individual-image-review'

  events:
    'click button[name="toggle-original"]': 'onClickToggleOriginal'
    'change input[name="proximity"]': 'onChangeProximity'

  constructor: ->
    super

    # Delay needed to pick up the change event for some reason.
    setTimeout => @fauxRangeInputs = FauxRangeInput.find @el.get 0

  onClickToggleOriginal: ->
    if @el.hasClass 'showing-original'
      @hideOriginal()
    else
      @showOriginal()

  onChangeProximity: (e) ->
    markIndex = e.currentTarget.getAttribute 'data-mark'
    @setProximity markIndex, e.currentTarget.value

  showOriginal: ->
    @el.addClass 'showing-original'

  hideOriginal: ->
    @el.removeClass 'showing-original'

  setProximity: (markIndex, value) ->
    @marks[markIndex].set "proximity-#{@index}", value

  destroy: ->
    @fauxRangeInputs.pop().destroy() until @fauxRangeInputs.length is 0
    super

module.exports = IndividualImageReview
