BaseController = require 'zooniverse/controllers/base-controller'

class ClassificationSummary extends BaseController
  classification: null

  className: 'classification-summary'
  template: require '../views/classification-summary'

  destroyDelay: 500

  events:
    'click button[name="ready-for-next"]': 'onClickReady'

  constructor: ->
    super
    @hide()

  show: ->
    @el.removeClass 'offscreen'

  onClickReady: ->
    @finish()

  finish: ->
    @hide()
    setTimeout (=> @destroy()), @destroyDelay

  hide: ->
    @el.addClass 'offscreen'

module.exports = ClassificationSummary
