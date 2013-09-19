BaseController = require 'zooniverse/controllers/base-controller'
User = require 'zooniverse/models/user'
Subject = require 'zooniverse/models/subject'

loadImage = require '../lib/load-image'
Classification = require 'zooniverse/models/classification'
MarkingSurface = require 'marking-surface'
CondorTool = require './condor-tool'
PresenceInspector = require './presence-inspector'

class Classifier extends BaseController
  className: 'classifier'
  template: require '../views/classifier'

  events:
    'click button[name="finish-marking"]': 'onClickFinishMarking'

  elements:
    '.subject-for-size': 'imgForSize'
    '.subject': 'subjectElement'

  constructor: ->
    super
    window.classifier = @

    @markingSurface = new MarkingSurface tool: CondorTool, width: 0, height: 0
    @subjectImage = @markingSurface.addShape 'image'
    @subjectElement.append @markingSurface.el

    User.on 'change', @onUserChange
    Subject.on 'fetch', @onSubjectFetch
    Subject.on 'select', @onSubjectSelect
    addEventListener 'resize', @onResize, false

  onUserChange: (e, user) =>
    Subject.next() unless @classification?

  onSubjectFetch: =>
    @startLoading()

  onSubjectSelect: (e, subject) =>
    @classification = new Classification {subject}

    loadImage subject.location.standard, (img) =>
      @imgForSize.attr 'src', img.src

      @rescale()

      @subjectImage.attr 'xlink:href', img.src

      @askForTags()
      @stopLoading()

  onResize: =>
    @rescale()

  rescale: ->
      scaledWidth = @imgForSize.width()
      scaledHeight = @imgForSize.height()

      @markingSurface.resize scaledWidth, scaledHeight

      @subjectImage.attr
        width: scaledWidth
        height: scaledHeight

  onClickFinishMarking: =>
    @askAboutIndividuals()

  startLoading: ->
    @el.addClass 'loading'

  stopLoading: ->
    @el.removeClass 'loading'

  askForTags: ->
    # Switch to the "mark all the tags" view

  askAboutIndividuals: ->
    presenceInspector = new PresenceInspector marks: @markingSurface.marks
    presenceInspector.el.appendTo @el

module.exports = Classifier
