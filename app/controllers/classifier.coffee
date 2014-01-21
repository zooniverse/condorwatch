BaseController = require 'zooniverse/controllers/base-controller'
User = require 'zooniverse/models/user'
Subject = require 'zooniverse/models/subject'

loadImage = require '../lib/load-image'
Classification = require 'zooniverse/models/classification'
MarkingSurface = require 'marking-surface'
MarkingTool = require './marking-tool'
ClassificationSummary = require './classification-summary'

DEV_SUBJECTS = [
  './dev-subject-images/CDY_0030.JPG'
  './dev-subject-images/CDY_0032.JPG'
  './dev-subject-images/CDY_0034.JPG'
  './dev-subject-images/CDY_0036.JPG'
  './dev-subject-images/CDY_0038.JPG'
]

NEXT_DEV_SUBJECT = ->
  DEV_SUBJECTS[DEV_SUBJECTS.push(DEV_SUBJECTS.shift()) - 1]

class Classifier extends BaseController
  className: 'classifier'
  template: require '../views/classifier'

  selectedTool: null

  elements:
    '.image-container': 'subjectContainer'
    'button[name="choose-animal"]': 'animalButtons'
    'button[name="confirm-animal"]': 'confirmAnimalButton'
    'input[name="label"]': 'labelInput'
    'button[name="tag-color"]': 'colorButtons'
    'button[name="dots"]': 'dotsButtons'
    'input[name="underlined"]': 'underlinedCheckbox'
    'button[name="proximity"]': 'proximityButtons'
    'button[name="finish-selection"]': 'finishSelectionButton'

  constructor: ->
    super
    window.classifier = @ if +location.port > 1023

    @markingSurface = new MarkingSurface
      tool: MarkingTool
      tabIndex: -1

    @subjectImage = @markingSurface.addShape 'image',
      width: '100%'
      height: '100%'
      preserveAspectRatio: 'none'

    @subjectContainer.append @markingSurface.el

    @markingSurface.on 'create-tool', (tool) =>
      tool.mark.on 'change', =>
        @reflectTool tool

    @markingSurface.on 'select-tool', @onSelectTool
    @markingSurface.on 'deselect-tool', @onSelectTool

    User.on 'change', @onUserChange
    Subject.on 'select', @onSubjectSelect

  onUserChange: (e, user) =>
    Subject.next() unless @classification?

  onSubjectSelect: (e, subject) =>
    @markingSurface.reset()
    @setState 'no-selection'

    @classification = new Classification {subject}

    loadImage subject.location.standard, (img) =>
      @subjectImage.attr 'xlink:href': NEXT_DEV_SUBJECT() || img.src # TODO
      @markingSurface.enable()

  onSelectTool: (tool) =>
    @selectedTool = tool

    if @selectedTool?
      if @selectedTool.mark.animal is 'condor'
        @setState 'condor-details', 'proximity-details', 'finish-selection'
      else if @selectedTool.mark.animal?
        @setState 'proximity-details', 'finish-selection'
      else
        @setState 'what-kind'

      @reflectTool @selectedTool

    else
      @setState 'no-selection'

  setState: (panels...) ->
    panelElements = @el.find '.state'
    toShow = panelElements.filter panels.map((className) -> ".#{className}").join ','

    panelElements.hide()
    toShow.show()

  reflectTool: (tool) =>
    return unless tool is @selectedTool

    @animalButtons.removeClass 'selected'
    @animalButtons.filter("[value='#{tool.mark.animal}']").addClass 'selected'

    @confirmAnimalButton.prop 'disabled', not tool.mark.animal?

    @labelInput.val tool.mark.label || ''

    @colorButtons.removeClass 'selected'
    @colorButtons.filter("[value='#{tool.mark.color}']").addClass 'selected'

    valuedDotsButtons = @dotsButtons.filter '[value]'
    valuedDotsButtons.removeClass 'selected'
    valuedDotsButtons.slice(0, tool.mark.dots || 0).addClass 'selected'

    @underlinedCheckbox.prop 'checked', !!tool.mark.underlined

    @proximityButtons.removeClass 'selected'
    @proximityButtons.filter("[value='#{tool.mark.proximity}']").addClass 'selected'

  showSummary: (onDestroySummary) ->
    @classification.set 'marks', [@markingSurface.marks...]

    classificationSummary = new ClassificationSummary {@classification}
    classificationSummary.el.appendTo @el
    @el.addClass 'showing-summary'

    classificationSummary.on 'destroying', =>
      @el.removeClass 'showing-summary'
      onDestroySummary?()

    setTimeout =>
      classificationSummary.show()

  sendClassification: ->
    # Save a copy of the marking surface's marks
    # in case we need to inspect them after it resets.
    @classification.set 'marks', [@markingSurface.marks...]
    console?.log JSON.stringify @classification
    # TODO: @classification.send()

  events:
    'click button[name="choose-animal"]': (e) ->
      @selectedTool.mark.set 'animal', e.currentTarget.value

    'click button[name="confirm-animal"]': ->
      @onSelectTool @selectedTool # TODO: Maybe this is a weird way to re-set the state.

    'input input[name="label"]': (e) ->
      @selectedTool.mark.set 'label', e.currentTarget.value

    'click button[name="tag-color"]': (e) ->
      @selectedTool.mark.set 'color', e.currentTarget.value

    'click button[name="dots"]': (e) ->
      @selectedTool.mark.set 'dots', parseFloat e.currentTarget.value

    'change input[name="underlined"]': (e) ->
      @selectedTool.mark.set 'underlined', e.currentTarget.checked

    'click button[name="proximity"]': (e) ->
      @selectedTool.mark.set 'proximity', e.currentTarget.value

    'click button[name="finish-selection"]': ->
      @markingSurface.selection.deselect()

    'click button[name="finish-subject"]': ->
      @sendClassification()
      @showSummary ->
        Subject.next()

module.exports = Classifier
