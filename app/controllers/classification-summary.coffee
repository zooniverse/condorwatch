BaseController = require 'zooniverse/controllers/base-controller'
guessCondor = require '../lib/guess-condor'

class ClassificationSummary extends BaseController
  marks: null

  className: 'classification-summary'
  template: require '../views/classification-summary'

  destroyDelay: 500

  events:
    'click button[name="dismiss"]': 'onClickDismiss'

  elements:
    '.condor-summaries': 'summaryContainer'
    'button[name="dismiss"]': 'nextButton'

  constructor: ->
    super
    @hide()

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
#     {animal: 'condor'}
#     {animal: 'turkeyVulture'}
#     {animal: 'turkeyVulture'}
#     {animal: 'raven'}
#     {animal: 'coyote'}
#     {animal: 'coyote'}
#     {animal: 'goldenEagle'}
#     {animal: 'carcassOrScale'}
#     {animal: 'carcassOrScale'}
#   ]

# cs.el.appendTo document.body

# cs.show()
