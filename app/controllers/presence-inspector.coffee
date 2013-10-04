BaseController = require 'zooniverse/controllers/base-controller'
ImageMagnifier = require 'image-magnifier'
$ = window.jQuery

class PresenceInspector extends BaseController
  marks: null
  otherTimes: null

  className: 'presence-inspector'
  template: require '../views/presence-inspector'

  onImage: -1 # Get next on init

  destroyDelay: 500

  magnifiers: null

  events:
    'click button[name="tag-present"]': 'onClickTagPresent'
    'click button[name="tag-not-present"]': 'onClickTagNotPresent'
    'click button[name="continue"]': 'onClickContinue'
    'click button[name="finish"]': 'onClickFinish'

  elements:
    '.all-images': 'allImagesContainer'
    '.other-image': 'otherImages'

  constructor: ->
    super

    @magnifiers = (new ImageMagnifier image for image in @otherImages)

    mark.on 'change', @onMarkChange for mark in @marks

    @hide()
    @next()

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
      continueButton = @el.find('button[name="continue"], button[name="finish"]').eq imageIndex

      for mark, markIndex in @marks
        yesButton = @el.find "button[name='tag-present'][value='#{markIndex}-#{imageIndex}']"
        noButton = @el.find "button[name='tag-not-present'][value='#{markIndex}-#{imageIndex}']"
        yesButton.toggleClass 'selected', mark.presence?[imageIndex] is true
        noButton.toggleClass 'selected', mark.presence?[imageIndex] is false

        continueButton.attr 'disabled', not continueButton.attr('disabled') and not mark.presence?[imageIndex]?

  next: ->
    @onImage += 1
    @allImagesContainer.attr 'data-on-image', @onImage
    @updatePresenceToggles()

  finish: ->
    @hide()
    setTimeout (=> @destroy()), @destroyDelay

  hide: ->
    @el.addClass 'offscreen'

  destroy: ->
    @magnifiers.pop().destroy() until @magnifiers.length is 0
    mark.off 'change', @onMarkChange for mark in @marks
    super

module.exports = PresenceInspector
