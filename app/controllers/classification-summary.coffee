BaseController = require 'zooniverse/controllers/base-controller'
guessCondor = require '../lib/guess-condor'
getCondorBio = require '../lib/get-condor-bio'
translate = require 't7e'
$ = window.jQuery

isAnythingButSocal = (test) ->
  test isnt 'Socal'

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
    guesses = []

    for condor, i in condors then do (i) =>
      condor = Object.create condor
      if @classification.subject.metadata.file?.indexOf('USFWS') > -1
        condor.source = 'Socal'
      else
        condor.source = isAnythingButSocal

      guess = guessCondor condor
      guesses.push guess

      guess.then (ids) =>
        @condorLabels.eq(i).html condor.label || '?' # Show what the user entered, not the actual ID

        if ids.length is 0
          @condorBioLinks.eq(i).html translate 'span', 'classificationSummary.noBioLink'
          @condorBioLinks.eq(i).prop 'href', '#/condors/no-bio'
        else
          @condorLabels.eq(i).attr 'title', "#{Math.floor (1 / ids.length) * 100}% #{translate 'classificationSummary.sureness'} #{ids[0]}"
          @condorBioLinks.eq(i).prop 'href', "#/condors/#{ids[0]}"

    $.when(guesses...).then (idSets...) =>
      setTimeout =>
        # Delay because we're still in the constructor and this will most likely happen instantly.
        @trigger 'guess', [idSets]

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
