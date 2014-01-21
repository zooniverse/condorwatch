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

  currentTool: null

  elements:
    '.image-container': 'subjectContainer'
    'button[name="choose-animal"]': 'animalButtons'
    'button[name="confirm-animal"]': 'confirmAnimalButton'
    'input[name="label"]': 'labelInput'
    'button[name="tag-color"]': 'colorButtons'
    'button[name="dots"]': 'dotsButtons'
    'input[name="underlined"]': 'underlinedCheckbox'
    'button[name="proximity"]': 'proximityButtons'
    'button[name="finish-marking"]': 'finishButton'

  constructor: ->
    super
    window.classifier = @ if +location.port > 1023

    @markingSurface = new MarkingSurface
      tool: MarkingTool
      tabIndex: -1

    @markingSurface.on 'create-tool', (tool) =>
      tool.mark.on 'change', =>
        @reflectTool tool

    @markingSurface.on 'select-tool', @onChangeToolSelction
    @markingSurface.on 'deselect-tool', @onChangeToolSelction

    @markingSurface.svgRoot.attr 'id', 'classifier-svg-root'

    @subjectImage = @markingSurface.addShape 'image',
      width: '100%'
      height: '100%'
      preserveAspectRatio: 'none'

    @subjectContainer.append @markingSurface.el

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

  onChangeToolSelction: (tool) =>
    @currentTool = tool

    if @currentTool?
      @reflectTool @currentTool
      if @currentTool.mark.animal is 'condor'
        @setState 'condor-details'
      else if @currentTool.mark.animal?
        @setState 'misc-details'
      else
        @setState 'what-kind'

    else
      @setState 'no-selection'

  setState: (panels...) ->
    panelElements = @el.find '.state'
    toShow = panelElements.filter ".#{panels.join '.'}"

    panelElements.css 'opacity', 0.25
    toShow.css 'opacity', 1

  reflectTool: (tool) =>
    console.log 'Reflecting', tool
    return unless tool is @currentTool

    @animalButtons.removeClass 'selected'
    @animalButtons.filter("[value='#{tool.mark.animal}']").addClass 'selected'

    @labelInput.val tool.mark.label || ''

    @colorButtons.removeClass 'selected'
    @colorButtons.filter("[value='#{tool.mark.color}']").addClass 'selected'

    @dotsButtons.removeClass 'selected'
    @dotsButtons.slice(0, tool.mark.dots + 1 || 0).addClass 'selected'

    @underlinedCheckbox.prop 'checked', tool.mark.underlined

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
      @currentTool.mark.set 'animal', e.currentTarget.value

    'click button[name="confirm-animal"]': ->
      if @currentTool.mark.animal is 'condor'
        @setState 'condor-details'
      else if @currentTool.mark.animal?
        @setState 'misc-details'

    'input input[name="label"]': (e) ->
      @currentTool.mark.set 'label', e.currentTarget.value

    'click button[name="tag-color"]': (e) ->
      @currentTool.mark.set 'color', e.currentTarget.value

    'click button[name="dots"]': (e) ->
      @currentTool.mark.set 'dots', parseFloat e.currentTarget.value

    'input input[name="underlined"]': ->
      @currentTool.mark.set 'underlined', e.currentTarget.checked

    'click button[name="proximity"]': ->
      @currentTool.mark.set 'proximity', parseFloat e.currentTarget.value

    'click button[name="finish-marking"]': ->
      @sendClassification()
      @showSummary ->
        Subject.next()

module.exports = Classifier
