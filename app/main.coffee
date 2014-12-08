$ = window.jQuery
$.noConflict()

t7e = require 't7e'
enUs = require './lib/en-us'

t7e.load enUs

LanguageManager = require 'zooniverse/lib/language-manager'
languageManager = new LanguageManager
  translations:
    en: label: 'English', strings: enUs
    fr: label: 'Français', strings: './translations/fr.json'
    pl: label: 'Polski', strings: './translations/pl.json'

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
  '#/field-guide/*': require './controllers/field-guide'
  '#/condors/:id': require './controllers/condor-bio-page'
  '#/science': require './controllers/science-page'
  '#/profile': require './controllers/profile'
  '#/education': require './controllers/education-page'
  notFound: '<div class="content-block"><div class="content-container"><h1>Page not found!</h1></div></div>'

document.body.appendChild stack.el

TopBar = require 'zooniverse/controllers/top-bar'
topBar = new TopBar
topBar.el.appendTo document.body

GoogleAnalytics = require 'zooniverse/lib/google-analytics'
analytics = new GoogleAnalytics
  account: 'UA-1224199-54'
  domain: 'condorwatch.org'

User = require 'zooniverse/models/user'

SPLIT_VALUES =
  talk_button_only: a: 'button_only', b: 'yes_or_no'
  talk_message: a: 'talk_about', b: 'discuss'
  tutorial: a: 'automatic', b: 'prompted', c: 'not_mentioned'

User.on 'change', (e, user) ->
  splits = user?.project?.splits
  defaultValue = if user? then 'no_split' else 'not_logged_in'

  GoogleAnalytics.current?.custom 1, 'talk_button_only', SPLIT_VALUES.talk_button_only[splits?.talk_button_only] ? defaultValue
  GoogleAnalytics.current?.custom 2, 'talk_message', SPLIT_VALUES.talk_message[splits?.talk_message] ? defaultValue
  GoogleAnalytics.current?.custom 3, 'tutorial', SPLIT_VALUES.tutorial[splits?.tutorial] ? defaultValue

User.fetch()

if ~location.search.indexOf 'log-analytics'
  for eventName in ['custom', 'track', 'event'] then do (eventName) ->
    GoogleAnalytics.current?.on eventName, (e, what...) ->
      console?.log "Analytics #{eventName}", what...

window.app = {api, siteNavigation, stack, topBar, analytics}
module.exports = window.app
