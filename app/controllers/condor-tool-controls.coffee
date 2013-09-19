{ToolControls} = require 'marking-surface'
$ = window.jQuery

class CondorToolControls extends ToolControls
  template: require('../views/condor-tool-controls')()

  constructor: ->
    super

    $el = $(@el)
    $el.on 'input', 'input[name="tag"]', @onChangeTag
    $el.on 'change', 'input[name="tag-hidden"]', @onChangeTagHidden
    $el.on 'change', 'input[name="proximity"]', @onChangeProximity
    $el.on 'click', 'button[name="delete"]', @onClickDelete
    $el.on 'click', 'button[name="next"]', @onClickNext
    $el.on 'click', 'button[name="done"]', @onClickDone

  onChangeTag: =>
    @tool.mark.set 'tag', @el.querySelector('input[name="tag"]').value

  onChangeTagHidden: =>
    @tool.mark.set 'tagHidden', @el.querySelector('input[name="tag-hidden"]').checked

  onChangeProximity: =>
    @tool.mark.set 'proximity', @el.querySelector('input[name="proximity"]').value

  onClickDelete: =>
    @tool.mark.destroy()

  onClickNext: =>
    @showProximity()

  onClickDone: =>
    @done()

  open: ->
    @el.style.display = ''
    @showIdentification()

  showIdentification: ->
    $el = $(@el)
    $el.find('.step').hide()
    $el.find('.identification.step').show()

  showProximity: ->
    $el = $(@el)
    $el.find('.step').hide()
    $el.find('.proximity.step').show()

  render: ->
    $el = $(@el)
    $el.find('button[name="next"]').attr 'disabled', (not @tool.mark.tag) and (not @tool.mark.tagHidden)

  done: ->
    @tool.deselect()

  close: ->
    @el.style.display = 'none'

  destroy: ->
    $(@el).off()
    super

module.exports = CondorToolControls
