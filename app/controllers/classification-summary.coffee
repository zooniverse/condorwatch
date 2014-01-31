BaseController = require 'zooniverse/controllers/base-controller'
guessCondor = require '../lib/guess-condor'
getCondorBio = require '../lib/get-condor-bio'
CondorSummary = require './condor-summary'

class ClassificationSummary extends BaseController
  classification: null

  className: 'classification-summary'
  template: require '../views/classification-summary'

  destroyDelay: 500

  events:
    'click button[name="ready-for-next"]': 'onClickReady'

  elements:
    '.condor-summaries': 'summaryContainer'
    'button[name="ready-for-next"]': 'nextButton'

  constructor: ->
    super
    @hide()

    for mark in @classification.get 'marks' when mark.animal is 'condor'
      {label, color, dots, underlined} = mark
      guessCondor {label, color, dots, underlined}, ([id]) =>
        summary = new CondorSummary
          condorId: id
          bioPromise: getCondorBio id
        @summaryContainer.append summary.el

  show: ->
    @el.removeClass 'offscreen'
    @nextButton.focus()

  onClickReady: ->
    @finish()

  finish: ->
    @hide()
    setTimeout (=> @destroy()), @destroyDelay

  hide: ->
    @el.addClass 'offscreen'

module.exports = ClassificationSummary
