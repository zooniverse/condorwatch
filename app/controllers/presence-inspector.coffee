BaseController = require 'zooniverse/controllers/base-controller'
IndividualImageReview = require './individual-image-review'
$ = window.jQuery

class PresenceInspector extends BaseController
  otherImages: null
  marks: null

  className: 'presence-inspector'
  template: require '../views/presence-inspector'

  onImage: -1 # Get next (0) on init

  destroyDelay: 500

  events:
    'click button[name="continue"]': 'onClickContinue'
    'click button[name="finish"]': 'onClickFinish'

  elements:
    '.individual-images': 'individualImagesContainer'

  constructor: ->
    super

    for image, i in @otherImages
      review = new IndividualImageReview {image, @marks, index: i, total: @otherImages.length}
      @individualImagesContainer.append review.el

    @hide()
    @next()

  onClickContinue: ->
    @next()

  onClickFinish: ->
    @finish()

  show: ->
    @el.removeClass 'offscreen'

  hide: ->
    @el.addClass 'offscreen'

  next: ->
    @onImage += 1
    @individualImagesContainer.attr 'data-on-image', @onImage

  finish: ->
    @hide()
    setTimeout (=> @destroy()), @destroyDelay

  destroy: ->
    mark.off 'change', @onMarkChange for mark in @marks
    super

module.exports = PresenceInspector
