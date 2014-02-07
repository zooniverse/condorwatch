BaseController = require 'zooniverse/controllers/base-controller'
StackOfPages = require 'stack-of-pages'
getCondorBio = require '../lib/get-condor-bio'
bioPageTemplate = require '../views/condor-bio-page'

class CondorBioPage extends BaseController
  className: 'condor-bio-page'

  constructor: ->
    super
    @el.on StackOfPages::activateEvent, @activate

  activate: ({originalEvent: {detail: params}}) =>
    @el.html ''
    getCondorBio params.id, (bio) =>
      @el.html bioPageTemplate bio

module.exports = CondorBioPage
