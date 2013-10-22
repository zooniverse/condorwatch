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
    'change input[name="proximity"]': 'onChangeProximity'

  constructor: ->
    super
    @fauxRangeInputs = FauxRangeInput.find @el.get 0

  onChangeProximity: (e) ->
    markIndex = e.currentTarget.getAttribute 'data-mark'
    @setProximity markIndex, e.currentTarget.value

  setProximity: (markIndex, value) ->
    @marks[markIndex].set "proximity-#{@index}", value

  destroy: ->
    @fauxRangeInputs.pop().destroy() until @fauxRangeInputs.length is 0
    super

module.exports = IndividualImageReview
