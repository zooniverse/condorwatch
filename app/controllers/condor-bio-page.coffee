BaseController = require 'zooniverse/controllers/base-controller'
StackOfPages = require 'stack-of-pages'
getCondorBio = require '../lib/get-condor-bio'
tagsTable = require '../lib/tags-table'
bioPageTemplate = require '../views/condor-bio-page'
cantFindBioPageTemplate = require '../views/cant-find-bio'

class CondorBioPage extends BaseController
  className: 'condor-bio-page'

  constructor: ->
    super
    @el.on StackOfPages::activateEvent, @activate

  activate: ({originalEvent: {detail: params}}) =>
    @el.html ''
    getCondorBio params.id, (bio) =>
      if bio?
        tagsTable.then (tags) =>
          bio.labels = [[], tags...].reduce (reduced, entry) ->
            if entry.id is bio.id and entry.label not in reduced
              reduced.push entry.label
            reduced

          @el.html bioPageTemplate bio
      else
        @el.html cantFindBioPageTemplate()

module.exports = CondorBioPage
