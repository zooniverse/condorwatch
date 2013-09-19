BaseController = require 'zooniverse/controllers/base-controller'

class PresenceInspector extends BaseController
  marks: null

  className: 'presence-inspector'
  template: require '../views/presence-inspector'

  constructor: ->
    super

module.exports = PresenceInspector
