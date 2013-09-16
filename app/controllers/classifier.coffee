BaseController = require 'zooniverse/controllers/base-controller'
User = require 'zooniverse/models/user'
Subject = require 'zooniverse/models/subject'
Classification = require 'zooniverse/models/classification'

loadImage = (src, cb) ->
  img = new Image
  img.onload = -> cb img.src
  img.src = src

class Classifier extends BaseController
  className: 'classifier'
  template: require '../views/classifier'

  elements:
    '.subject': 'subjectImg'

  constructor: ->
    super
    User.on 'change', @onUserChange
    Subject.on 'fetch', @onSubjectFetch
    Subject.on 'select', @onSubjectSelect

  onUserChange: (e, user) =>
    Subject.next() unless @classification?

  onSubjectFetch: =>
    @startLoading()

  onSubjectSelect: (e, subject) =>
    @classification = new Classification {subject}

    loadImage subject.location.standard, (src) =>
      @subjectImg.attr 'src', src
      @stopLoading()

  startLoading: ->
    @el.addClass 'loading'

  stopLoading: ->
    @el.removeClass 'loading'

module.exports = Classifier
