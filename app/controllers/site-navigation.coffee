BaseController = require 'zooniverse/controllers/base-controller'

class SiteNavigation extends BaseController
  tagName: 'nav'
  className: 'site-navigation'
  template: require '../views/site-navigation'

module.exports = SiteNavigation
