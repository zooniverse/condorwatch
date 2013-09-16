$ = window.jQuery
$.noConflict()

Api = require 'zooniverse/lib/api'
api = new Api project: 'worms'

StackOfPages = require 'stack-of-pages/src/stack-of-pages'
stack = new StackOfPages
  '#/': 'Home'
  '#/classify': require './controllers/classifier'
  DEFAULT: '#/classify'

TopBar = require 'zooniverse/controllers/top-bar'
topBar = new TopBar

document.body.appendChild stack.el
topBar.el.appendTo document.body

User = require 'zooniverse/models/user'
User.fetch()

window.app = {api, stack, topBar}
module.exports = window.app
