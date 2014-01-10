BaseController = require 'zooniverse/controllers/base-controller'
guessCondor = require '../lib/guess-condor'
getCondorBio = require '../lib/get-condor-bio'

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

    for mark in @classification.get 'marks'
      {label, color, dots, underlined} = mark
      guessCondor {label, color, dots, underlined}, (ids) ->
        console.log 'Guessing', ids

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
