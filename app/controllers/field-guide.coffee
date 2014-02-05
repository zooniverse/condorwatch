BaseController = require 'zooniverse/controllers/base-controller'

class FieldGuide extends BaseController
  className: 'field-guide'
  template: require '../views/field-guide'

module.exports = FieldGuide
