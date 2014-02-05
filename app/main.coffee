$ = window.jQuery
$.noConflict()

t7e = require 't7e'
enUs = require './lib/en-us'

t7e.load enUs

LanguageManager = require 'zooniverse/lib/language-manager'
languageManager = new LanguageManager
  translations:
    en: label: 'English', strings: enUs
    es: label: 'Español', strings: './dev-translations/es.json'

languageManager.on 'change-language', (e, code, strings) ->
  t7e.load strings
  t7e.refresh()

Api = require 'zooniverse/lib/api'
api = new Api project: 'condor'

SiteNavigation = require './controllers/site-navigation'
siteNavigation = new SiteNavigation
siteNavigation.el.appendTo document.body

StackOfPages = require 'stack-of-pages'
stack = new StackOfPages
  '#/': require './controllers/home-page'
  '#/about': require './controllers/about-page'
  '#/classify': require './controllers/classifier'
  '#/field-guide': require './controllers/field-guide'
  '#/condors/:id': require './controllers/condor-bio-page'
  '#/science': require './controllers/science-page'
  '#/profile': require './controllers/profile'
  '#/education': require './controllers/education-page'
  NOT_FOUND: '<div class="content-block"><div class="content-container"><h1>Page not found!</h1></div></div>'
  ERROR: '<div class="content-block"><div class="content-container"><h1>There was an error!</h1></div></div>'

document.body.appendChild stack.el

TopBar = require 'zooniverse/controllers/top-bar'
topBar = new TopBar

topBar.el.appendTo document.body

browserDialog = require 'zooniverse/controllers/browser-dialog'
browserDialog.check msie: 9

User = require 'zooniverse/models/user'
User.fetch()

window.app = {api, siteNavigation, stack, topBar}
module.exports = window.app
