BaseController = require 'zooniverse/controllers/base-controller'
Footer = require 'zooniverse/controllers/footer'
StackOfPages = require 'stack-of-pages'
$ = window.jQuery

class HomePage extends BaseController
  className: 'home-page'
  template: require '../views/home-page'

  headerSlideDelay: 150
  animationDuration: 333

  elements:
    '.for-footer': 'footerContainer'

  constructor: ->
    super
    @navigationComponent = $('.site-navigation .for-home-page')

    @footer = new Footer
    @footer.el.appendTo @footerContainer

    @el.on StackOfPages::activateEvent, @activate
    @el.on StackOfPages::deactivateEvent, @deactivate

  activate: =>
    setTimeout @showNavigationComponent, @headerSlideDelay

  deactivate: ({originalEvent: {detail: params}}) =>
    if params.initial
      # This is the on-load deactivation
      @hideNavigationComponent 0
    else
      setTimeout @hideNavigationComponent, @headerSlideDelay

  showNavigationComponent: (duration = @animationDuration) =>
    @navigationComponent.slideDown duration
    @navigationComponent.animate {
      opacity: 1
    }, {
      duration: duration
      queue: false
    }

  hideNavigationComponent: (duration = @animationDuration) =>
    @navigationComponent.slideUp duration
    @navigationComponent.animate {
      opacity: 0
    }, {
      duration: duration * 0.5
      queue: false
    }

module.exports = HomePage
