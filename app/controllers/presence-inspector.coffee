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

    @hide()
    @next()

  onMouseMove: (e) ->
    image = @otherImages.eq @onImage
    {left, top} = image.offset()
    width = image.width()
    height = image.height()

    x = (e.pageX - left) / width
    y = (e.pageY - top) / height

    inImage = 0 <= x <= 1 and 0 <= y <= 1

    if inImage
      @magnifier.offset
        left: e.pageX - (@magnifier.width() / 2)
        top: e.pageY - (@magnifier.height() / 2)

      @magnifiedImage.offset
        left: left - ((@magnifiedImage.width() - width) * x)
        top: top - ((@magnifiedImage.height() - height) * y)

    @magnifier.toggleClass 'active', inImage

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
