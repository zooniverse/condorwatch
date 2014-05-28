BaseController = require 'zooniverse/controllers/base-controller'
StackOfPages = require 'stack-of-pages'
$ = window.jQuery

class FieldGuide extends BaseController
  className: 'field-guide'
  template: require '../views/field-guide'

  elements:
    '.back-to-classify': 'backToClassifyLink'

  constructor: ->
    super
    @el.on StackOfPages::activateEvent, @activate

  activate: ({originalEvent: {detail: params}}) =>
    @backToClassifyLink.toggle params._ is 'from-classify'

    # Scroll to shortcuts, e.g. #/field-guide/wing-tags scrolls to the "wing-tags-shortcut"-classed tag.
    shortcutTop = @el.find(".#{params._}-shortcut").offset()?.top
    if shortcutTop?
      $('html, body').animate scrollTop: shortcutTop, 1000

module.exports = FieldGuide
