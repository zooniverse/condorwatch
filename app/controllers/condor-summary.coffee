BaseController = require 'zooniverse/controllers/base-controller'

class CondorSummary extends BaseController
  bioPromise: null

  className: 'condor-summary'
  template: require '../views/condor-summary'

  elements:
    '[data-place-for]': 'placesFor'

  constructor: ->
    super

    @bioPromise.then (bio) =>
      console.log 'Got bio', bio
      for property, value of bio
        value = 'n/a' if value instanceof Date and isNaN value
        @placesFor.filter("[data-place-for='#{property}']").html value

module.exports = CondorSummary
