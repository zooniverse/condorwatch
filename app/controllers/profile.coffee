BaseController = require 'zooniverse/controllers/base-controller'

class Profile extends BaseController
  className: 'profile'
  template: require '../views/profile'

module.exports = Profile
