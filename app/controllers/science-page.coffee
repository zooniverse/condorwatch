BaseController = require 'zooniverse/controllers/base-controller'

class SciencePage extends BaseController
  className: 'science-page'
  template: require '../views/science-page'

module.exports = SciencePage
