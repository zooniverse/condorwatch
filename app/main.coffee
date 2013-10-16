$ = window.jQuery
$.noConflict()

t7e = require 't7e'
t7e.load require './lib/en-us'

Api = require 'zooniverse/lib/api'
api = new Api project: 'worms'

SiteNavigation = require './controllers/site-navigation'
siteNavigation = new SiteNavigation
siteNavigation.el.appendTo document.body

StackOfPages = require 'stack-of-pages/src/stack-of-pages'
stack = new StackOfPages
  '#/': require './controllers/home-page'
  '#/about': require './controllers/about-page'
  '#/classify': require './controllers/classifier'
  '#/science': require './controllers/science-page'
  '#/profile': require './controllers/profile'
  '#/education': require './controllers/education-page'
  NOT_FOUND: '<div class="content-block"><div class="content-container"><h1>Page not found!</h1></div></div>'
  ERROR: '<div class="content-block"><div class="content-container"><h1>There was an error!</h1></div></div>'

for pageEl in stack.el.children
  $(pageEl).addClass 'page-in-stack'

document.body.appendChild stack.el

TopBar = require 'zooniverse/controllers/top-bar'
topBar = new TopBar

topBar.el.appendTo document.body

browserDialog = require 'zooniverse/controllers/browser-dialog'
browserDialog.check msie: 9

User = require 'zooniverse/models/user'
User.fetch()

# Don't wait for a double-tap check on buttons.
PREVENTED_DEFAULT_ATTR = 'touchstart-default-prevented'
$(document).on 'touchstart', 'button', (e) ->
  e.preventDefault()
  button = $(@)
  button.attr PREVENTED_DEFAULT_ATTR, true
  $(document).one 'touchend', -> setTimeout -> button.attr PREVENTED_DEFAULT_ATTR, false

$(document).on 'touchend', 'button', (e) ->
  button = $(@)
  button.trigger 'click' if button.attr PREVENTED_DEFAULT_ATTR

window.app = {api, siteNavigation, stack, topBar}
module.exports = window.app
