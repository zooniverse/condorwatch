BaseController = require 'zooniverse/controllers/base-controller'

class SiteNavigation extends BaseController
  tagName: 'nav'
  className: 'site-navigation'
  template: require '../views/site-navigation'

  activeClass: 'active'

  elements:
    'a': 'links'

  constructor: ->
    super
    addEventListener 'hashchange', @onHashChange, false
    @onHashChange()

  onHashChange: =>
    @links.removeClass @activeClass
    @links.filter("[href='#{location.hash}']").addClass @activeClass

module.exports = SiteNavigation
