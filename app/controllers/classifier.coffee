BaseController = require 'zooniverse/controllers/base-controller'
User = require 'zooniverse/models/user'
Subject = require 'zooniverse/models/subject'

loadImage = require '../lib/load-image'
Classification = require 'zooniverse/models/classification'
MarkingSurface = require 'marking-surface'
MarkingTool = require './marking-tool'
ClassificationSummary = require './classification-summary'

DEV_SUBJECT = './dev-subject-images/CDY_0034.JPG'

DEV_OTHERS = [
  './dev-subject-images/CDY_0030.JPG'
  './dev-subject-images/CDY_0032.JPG'
  './dev-subject-images/CDY_0036.JPG'
  './dev-subject-images/CDY_0038.JPG'
]

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
      tool: MarkingTool

    @markingSurface.svgRoot.attr 'id', 'classifier-svg-root'

    @subjectImage = @markingSurface.addShape 'image',
      width: '100%'
      height: '100%'
      preserveAspectRatio: 'none'

    @subjectContainer.append @markingSurface.el

    User.on 'change', @onUserChange
    Subject.on 'fetch', @onSubjectFetch
    Subject.on 'select', @onSubjectSelect

    # addEventListener 'resize', @rescale, false

  activate: ->
    # setTimeout @rescale, 100

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
        'xlink:href': DEV_SUBJECT || img.src

      @stopLoading()

      @markingSurface.enable()

  onClickFinishMarking: ->
    @showSummary()

  rescale: =>
    setTimeout =>
      over = innerHeight - document.body.clientHeight
      @subjectContainer.height parseFloat(@subjectContainer.height()) + over

  startLoading: ->
    @el.addClass 'loading'

  stopLoading: ->
    @el.removeClass 'loading'

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
