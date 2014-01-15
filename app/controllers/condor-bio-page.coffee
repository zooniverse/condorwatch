BaseController = require 'zooniverse/controllers/base-controller'
getCondorBio = require '../lib/get-condor-bio'
bioPageTemplate = require '../views/condor-bio-page'

class CondorBioPage extends BaseController
  className: 'condor-bio-page'

  activate: ({id}) ->
    @el.html ''
    getCondorBio id, (bio) =>
      @el.html bioPageTemplate bio

module.exports = CondorBioPage
