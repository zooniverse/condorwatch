BaseController = require 'zooniverse/controllers/base-controller'

class ClassificationSummary extends BaseController
  classification: null

  className: 'classification-summary'
  template: require '../views/classification-summary'

module.exports = ClassificationSummary
