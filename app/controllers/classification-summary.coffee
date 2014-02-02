BaseController = require 'zooniverse/controllers/base-controller'
guessCondor = require '../lib/guess-condor'
getCondorBio = require '../lib/get-condor-bio'

class ClassificationSummary extends BaseController
  marks: null

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

    condors = (mark for mark in @marks when mark.animal is 'condor')

    for condor, i in condors then do (i) =>
      guessCondor(condor).then (ids) =>
        if ids.length is 1
          @condorLabels.eq(i).html ids[0]
          @condorBioLinks.eq(i).prop 'href', "#/condors/#{ids[0]}"
        else
          @condorSummaries.eq(i).addClass 'unknown-condor'

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

# cs = new ClassificationSummary
#   marks: [
#     {animal: 'condor', label: '-7'}
#     {animal: 'turkeyVulture'}
#     {animal: 'turkeyVulture'}
#     {animal: 'condor', label: '21'}
#     {animal: 'raven'}
#     {animal: 'coyote'}
#     {animal: 'coyote'}
#     {animal: 'goldenEagle'}
#     {animal: 'carcassOrScale'}
#     {animal: 'carcassOrScale'}
#   ]

# cs.el.appendTo document.body

# cs.show()
