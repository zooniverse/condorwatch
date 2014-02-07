BaseController = require 'zooniverse/controllers/base-controller'
StackOfPages = require 'stack-of-pages'

class FieldGuide extends BaseController
  className: 'field-guide'
  template: require '../views/field-guide'

  elements:
    '.back-to-classify': 'backToClassifyLink'

  constructor: ->
    super
    @el.on StackOfPages::activateEvent, @activate

  activate: =>
    @backToClassifyLink.toggle !!~location.hash.indexOf 'from-classify'

module.exports = FieldGuide
