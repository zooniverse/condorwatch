BaseController = require 'zooniverse/controllers/base-controller'

class FieldGuide extends BaseController
  className: 'field-guide'
  template: require '../views/field-guide'

  elements:
    '.back-to-classify': 'backToClassifyLink'

  activate: ->
    @backToClassifyLink.toggle !!~location.hash.indexOf 'from-classify'

module.exports = FieldGuide
