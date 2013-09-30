BaseController = require 'zooniverse/controllers/base-controller'
User = require 'zooniverse/models/user'
Subject = require 'zooniverse/models/subject'

loadImage = require '../lib/load-image'
Classification = require 'zooniverse/models/classification'
MarkingSurface = require 'marking-surface'
CondorTool = require './condor-tool'
PresenceInspector = require './presence-inspector'
ClassificationSummary = require './classification-summary'

class Classifier extends BaseController
  className: 'classifier'
  template: require '../views/classifier'

  events:
    'click button[name="finish-marking"]': 'onClickFinishMarking'
    'click button[name="no-tags"]': 'onClickNoTags'

  elements:
    '.subject-for-size': 'imgForSize'
    '.subject': 'subjectElement'
    'button[name="finish-marking"]': 'finishButton'
    'button[name="no-tags"]': 'noTagsButton'

  constructor: ->
    super
    window.classifier = @

    @markingSurface = new MarkingSurface tool: CondorTool, width: 0, height: 0
    @markingSurface.on 'create-mark', @onChangeMarkCount
    @markingSurface.on 'destroy-mark', @onChangeMarkCount

    @subjectImage = @markingSurface.addShape 'image'
    @subjectElement.append @markingSurface.el

    User.on 'change', @onUserChange
    Subject.on 'fetch', @onSubjectFetch
    Subject.on 'select', @onSubjectSelect
    addEventListener 'resize', @onResize, false

    @onChangeMarkCount()

  onChangeMarkCount: =>
    @finishButton.prop 'disabled', @markingSurface.marks.length is 0
    @noTagsButton.prop 'disabled', @markingSurface.marks.length isnt 0

  onUserChange: (e, user) =>
    Subject.next() unless @classification?

  onSubjectFetch: =>
    @startLoading()

  onSubjectSelect: (e, subject) =>
    @markingSurface.reset()

    @classification = new Classification {subject}

    loadImage subject.location.standard, (img) =>
      @imgForSize.attr 'src', img.src

      @rescale()

      @subjectImage.attr 'xlink:href', img.src

      @askForTags()
      @stopLoading()

      @markingSurface.enable()

  onResize: =>
    @rescale()

  rescale: ->
    scaledWidth = @imgForSize.width()
    scaledHeight = @imgForSize.height()

    @markingSurface.resize scaledWidth, scaledHeight

    @subjectImage.attr
      width: scaledWidth
      height: scaledHeight

  onClickFinishMarking: ->
    @askAboutIndividuals()

  onClickNoTags: ->
    @showSummary()

  startLoading: ->
    @el.addClass 'loading'

  stopLoading: ->
    @el.removeClass 'loading'

  askForTags: ->
    # Switch to the "mark all the tags" view

  askAboutIndividuals: ->
    @markingSurface.disable()

    presenceInspector = new PresenceInspector
      marks: @markingSurface.marks
      otherTimes: @classification?.subject?.other_times || [
        '//placehold.it/640x480.png&text=Ten minutes before'
        '//placehold.it/640x480.png&text=Five minutes before'
        '//placehold.it/640x480.png&text=Five minutes after'
        '//placehold.it/640x480.png&text=Ten minutes after'
      ]

    presenceInspector.el.appendTo @el

    @el.addClass 'inspecting-individuals'

    presenceInspector.on 'destroying', =>
      @el.removeClass 'inspecting-individuals'
      @showSummary()

    setTimeout =>
      presenceInspector.show()

  showSummary: ->
    @sendClassification()

    classificationSummary = new ClassificationSummary {@classification}

    classificationSummary.el.appendTo @el

    @el.addClass 'showing-summary'

    classificationSummary.on 'destroying', =>
      @el.removeClass 'showing-summary'
      Subject.next()

    setTimeout =>
      classificationSummary.show()

  sendClassification: ->
    @classification.set 'marks', [@markingSurface.marks...]
    console?.log JSON.stringify @classification
    # @classification.send()

module.exports = Classifier
