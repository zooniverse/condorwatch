BaseController = require 'zooniverse/controllers/base-controller'
guessCondor = require '../lib/guess-condor'
getCondorBio = require '../lib/get-condor-bio'
translate = require 't7e'

class ClassificationSummary extends BaseController
  classification: null

  className: 'classification-summary'
  template: require '../views/classification-summary'

  destroyDelay: 500

  events:
    'click button[name="dismiss"]': 'onClickDismiss'

  elements:
    '.condor-summary': 'condorSummaries'
    '.condor-tag-label': 'condorLabels'
    '.condor-bio-link': 'condorBioLinks'
    'button[name="dismiss"]': 'nextButton'

  constructor: ->
    super
    @hide()

    condors = (mark for mark in @classification.get 'marks' when mark.animal is 'condor')

    for condor, i in condors then do (i) =>
      guessCondor(condor).then (ids) =>
        if ids.length is 0
          @condorSummaries.eq(i).addClass 'unknown-condor'
        else
          @condorLabels.eq(i).html ids[0]
          @condorLabels.eq(i).attr 'title', "#{Math.floor (1 / ids.length) * 100}% #{translate 'classificationSummary.sure'}"
          @condorBioLinks.eq(i).prop 'href', "#/condors/#{ids[0]}"

  show: ->
    @el.removeClass 'offscreen'
    @nextButton.focus()

  onClickDismiss: ->
    @finish()

  finish: ->
    @hide()
    setTimeout (=> @destroy()), @destroyDelay

  hide: ->
    @el.addClass 'offscreen'

module.exports = ClassificationSummary
