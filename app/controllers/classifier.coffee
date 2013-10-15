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
    '.subject': 'subjectContainer'
    'button[name="finish-marking"]': 'finishButton'
    'button[name="no-tags"]': 'noTagsButton'

  constructor: ->
    super
    window.classifier = @

    @markingSurface = new MarkingSurface
      width: 770
      height: 440
      tool: CondorTool

    @markingSurface.on 'create-mark', @onChangeMarkCount
    @markingSurface.on 'destroy-mark', @onChangeMarkCount

    @subjectImage = @markingSurface.addShape 'image',
      width: 770
      height: 440
      preserveAspectRatio: 'none'

    @subjectContainer.append @markingSurface.el

    User.on 'change', @onUserChange
    Subject.on 'fetch', @onSubjectFetch
    Subject.on 'select', @onSubjectSelect

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
      # @markingSurface.resize img.width, img.height

      @subjectImage.attr
        'xlink:href': img.src
        # width: img.width
        # height: img.height

      @askForTags()
      @stopLoading()

      @markingSurface.enable()

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
      otherTimes: @classification?.subject?.other_times || Subject.instances.map((subject) -> subject.location.standard)[...4]

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
