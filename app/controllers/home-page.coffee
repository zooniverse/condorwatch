BaseController = require 'zooniverse/controllers/base-controller'
Footer = require 'zooniverse/controllers/footer'
$ = window.jQuery

class HomePage extends BaseController
  className: 'home-page'
  template: require '../views/home-page'

  animationDuration: 250

  elements:
    '.for-footer': 'footerContainer'

  constructor: ->
    super
    @navigationComponent = $('.site-navigation .for-home-page')

    @footer = new Footer
    @footer.el.appendTo @footerContainer

  activate: ->
    @showNavigationComponent()

  deactivate: ->
    @hideNavigationComponent()

  showNavigationComponent: ->
    @navigationComponent.slideDown @animationDuration
    @navigationComponent.animate {
      opacity: 1
    }, {
      duration: @animationDuration * 1.75
      queue: false
    }

  hideNavigationComponent: ->
    @navigationComponent.slideUp @animationDuration
    @navigationComponent.animate {
      opacity: 0
    }, {
      duration: @animationDuration * 0.75
      queue: false
    }

module.exports = HomePage
