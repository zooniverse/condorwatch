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
  '#/': "<h1>Home</h1>#{(new Array 100).join '<p>Lorem ipsum dolor sit amet</p>'}"
  '#/about': "<h1>About</h1>#{(new Array 100).join '<p>Lorem ipsum dolor sit amet</p>'}"
  '#/classify': require './controllers/classifier'
  '#/profile': "<h1>Profile</h1>#{(new Array 100).join '<p>Lorem ipsum dolor sit amet</p>'}"
  '#/education': "<h1>Education</h1>#{(new Array 100).join '<p>Lorem ipsum dolor sit amet</p>'}"
  DEFAULT: '#/classify'

TopBar = require 'zooniverse/controllers/top-bar'
topBar = new TopBar

document.body.appendChild stack.el
topBar.el.appendTo document.body

User = require 'zooniverse/models/user'
User.fetch()

window.app = {api, siteNavigation, stack, topBar}
module.exports = window.app
