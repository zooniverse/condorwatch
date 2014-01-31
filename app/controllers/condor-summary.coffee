BaseController = require 'zooniverse/controllers/base-controller'
moment = require 'moment'

class CondorSummary extends BaseController
  condorId: ''
  bioPromise: null

  className: 'condor-summary'
  template: require '../views/condor-summary'

  elements:
    '[data-place-for]': 'placesFor'

  constructor: ->
    super

    @bioPromise.then (bio) =>
      for property, value of bio
        if value instanceof Date
          value = moment value
          if value.isValid()
            value = value.format 'MM-DD-YYYY'
          else
            value = 'n/a'
        else if not value?
          value = '&mdash;'

        @placesFor.filter("[data-place-for='#{property}']").html value

module.exports = CondorSummary
