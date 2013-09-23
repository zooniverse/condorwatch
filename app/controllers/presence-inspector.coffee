BaseController = require 'zooniverse/controllers/base-controller'
$ = window.jQuery

class PresenceInspector extends BaseController
  marks: null
  otherTimes: null

  className: 'presence-inspector'
  template: require '../views/presence-inspector'

  onImage: 0

  destroyDelay: 500

  events:
    'click button[name="tag-present"]': 'onClickTagPresent'
    'click button[name="tag-not-present"]': 'onClickTagNotPresent'
    'click button[name="continue"]': 'onClickContinue'
    'click button[name="finish"]': 'onClickFinish'

  elements:
    '.all-images': 'imagesContainer'

  constructor: ->
    super

    for mark in @marks
      mark.on 'change', @onMarkChange

    @hide()

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
    @imagesContainer.attr 'data-on-image', @onImage

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
