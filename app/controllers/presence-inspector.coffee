BaseController = require 'zooniverse/controllers/base-controller'
$ = window.jQuery

class PresenceInspector extends BaseController
  marks: null
  otherTimes: null

  className: 'presence-inspector'
  template: require '../views/presence-inspector'

  onImage: -1

  destroyDelay: 500

  events:
    'mousemove': 'onMouseMove'
    'click button[name="tag-present"]': 'onClickTagPresent'
    'click button[name="tag-not-present"]': 'onClickTagNotPresent'
    'click button[name="continue"]': 'onClickContinue'
    'click button[name="finish"]': 'onClickFinish'

  elements:
    '.all-images': 'allImagesContainer'
    '.image-container': 'imageContainers'
    '.other-image': 'otherImages'
    '.magnifier': 'magnifier'
    '.magnified-image': 'magnifiedImage'

  constructor: ->
    super

    for mark in @marks
      mark.on 'change', @onMarkChange

    @magnifier.hide()
    @hide()
    @next()

  onMouseMove: (e) ->
    currentImageContainerNode = @imageContainers.get @onImage
    {left, right, top, bottom} = currentImageContainerNode.getBoundingClientRect()

    if left < e.pageX < right and top < e.pageY < bottom
      @magnifier.fadeIn 100
      @moveMagnifier e.pageX, e.pageY
    else
      @magnifier.fadeOut 100

  onClickTagPresent: (e) ->
    [mark, image] = $(e.currentTarget).val().split '-'
    @markPresence mark, image, true

  onClickTagNotPresent: (e) ->
    [mark, image] = $(e.currentTarget).val().split '-'
    @markPresence mark, image, false

  onClickContinue: ->
    @next()

  onClickFinish: ->
    @finish()

  onMarkChange: =>
    @updatePresenceToggles()

  show: ->
    @el.removeClass 'offscreen'

  moveMagnifier: (left, top) ->
    @magnifier.offset
      left: left - (@magnifier.width() / 2)
      top: top - (@magnifier.height() / 2)

    currentImage = @otherImages.eq @onImage
    currentImageOffset = currentImage.offset()
    @magnifiedImage.offset
      left: currentImageOffset.left - ((@magnifiedImage.width() - currentImage.width()) / 2)
      top: currentImageOffset.top - ((@magnifiedImage.height() - currentImage.height()) / 2)

  markPresence: (mark, image, present) ->
    @marks[mark].presence ?= []
    @marks[mark].presence[image] = present
    @marks[mark].trigger 'change'

  updatePresenceToggles: ->
    for image, imageIndex in @otherTimes
      for mark, markIndex in @marks
        yesButton = @el.find "button[name='tag-present'][value='#{markIndex}-#{imageIndex}']"
        noButton = @el.find "button[name='tag-not-present'][value='#{markIndex}-#{imageIndex}']"
        yesButton.toggleClass 'selected', mark.presence?[imageIndex] is true
        noButton.toggleClass 'selected', mark.presence?[imageIndex] is false

  next: ->
    @onImage += 1
    @allImagesContainer.attr 'data-on-image', @onImage
    @magnifiedImage.attr 'src', @otherTimes[@onImage]

  finish: ->
    @hide()
    setTimeout (=> @destroy()), @destroyDelay

  hide: ->
    @el.addClass 'offscreen'

  destroy: ->
    for mark in @marks
      mark.off 'change', @onMarkChange

    super

module.exports = PresenceInspector
