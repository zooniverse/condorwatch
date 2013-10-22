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
      tool: CondorTool

    @markingSurface.svgRoot.attr 'id', 'classifier-svg-root'

    @markingSurface.on 'create-mark', @onChangeMarkCount
    @markingSurface.on 'destroy-mark', @onChangeMarkCount

    @subjectImage = @markingSurface.addShape 'image',
      width: '100%'
      height: '100%'
      preserveAspectRatio: 'none'

    @subjectContainer.append @markingSurface.el

    User.on 'change', @onUserChange
    Subject.on 'fetch', @onSubjectFetch
    Subject.on 'select', @onSubjectSelect

    # addEventListener 'resize', @rescale, false

    @onChangeMarkCount()

  activate: ->
    # setTimeout @rescale, 100

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

      @askForTags()
      @stopLoading()

      @markingSurface.enable()

  onClickFinishMarking: ->
    @askAboutIndividuals()

  onClickNoTags: ->
    @showSummary()

  rescale: =>
    setTimeout =>
      over = innerHeight - document.body.clientHeight
      @subjectContainer.height parseFloat(@subjectContainer.height()) + over

  startLoading: ->
    @el.addClass 'loading'

  stopLoading: ->
    @el.removeClass 'loading'

  askForTags: ->
    # Switch to the "mark all the tags" view

  askAboutIndividuals: ->
    @markingSurface.disable()

    presenceInspector = new PresenceInspector
      otherImages: @classification?.subject?.other_times || Subject.instances.map((subject) -> subject.location.standard)[...4]
      marks: @markingSurface.marks

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
