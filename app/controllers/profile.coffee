BaseController = require 'zooniverse/controllers/base-controller'
BaseProfile = require 'zooniverse/controllers/profile'

class Profile extends BaseController
  className: 'profile'
  template: require '../views/profile'

  constructor: ->
    super

    @profile = new BaseProfile
    @el.find('.content-container').append @profile.el

module.exports = Profile
