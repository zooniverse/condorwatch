BaseController = require 'zooniverse/controllers/base-controller'

class EducationPage extends BaseController
  className: 'education-page'
  template: require '../views/education-page'

module.exports = EducationPage
