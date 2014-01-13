BaseController = require 'zooniverse/controllers/base-controller'

class CondorBioPage extends BaseController
  className: 'condor-bio-page'
  template: require '../views/condor-bio-page'

  activate: ({id}) ->

module.exports = CondorBioPage
