{ToolControls} = require 'marking-surface'
$ = window.jQuery

KEYS =
  return: 13
  esc: 27

class CondorToolControls extends ToolControls
  template: require('../views/condor-tool-controls')()

  constructor: ->
    super

    @el.querySelector('form.identification').addEventListener 'submit', @onSubmitIdentification, false
    @el.querySelector('form.proximity').addEventListener 'submit', @onSubmitProximity, false
    $el = $(@el)
    $el.on 'input', 'input[name="tag"]', @onChangeTag
    $el.on 'change', 'input[name="tag-hidden"]', @onChangeTagHidden
    $el.on 'change', 'input[name="proximity"]', @onChangeProximity
    $el.on 'click', 'button[name="delete"]', @onClickDelete
    $el.on 'keydown', @onKeyDown

  onChangeTag: =>
    @tool.mark.set 'tag', @el.querySelector('input[name="tag"]').value

  onChangeTagHidden: =>
    @tool.mark.set 'tagHidden', @el.querySelector('input[name="tag-hidden"]').checked

  onChangeProximity: =>
    @tool.mark.set 'proximity', @el.querySelector('input[name="proximity"]').value

  onClickDelete: =>
    @tool.mark.destroy()

  onSubmitIdentification: (e) =>
    e.preventDefault()
    e.stopPropagation()
    @showProximity()
    false

  onSubmitProximity: (e) =>
    e.preventDefault()
    e.stopPropagation()
    @done()
    false

  onKeyDown: (e) =>
    switch e.which
      when KEYS.return
        e.preventDefault()
        $(@el).find('[type="submit"]:visible').first().click() # WTF
      when KEYS.esc
        @tool.mark.destroy()

  open: ->
    @el.style.display = ''
    @showIdentification()

  showIdentification: ->
    $el = $(@el)
    $el.find('.step').hide()
    $el.find('.identification.step').show()
    @focusInput()

  showProximity: ->
    $el = $(@el)
    $el.find('.step').hide()
    $el.find('.proximity.step').show()
    @focusInput()

  focusInput: ->
    setTimeout => $(@el).find('input:visible').first().focus()

  render: ->
    $el = $(@el)
    $el.find('button[name="next"]').attr 'disabled', (not @tool.mark.tag) and (not @tool.mark.tagHidden)

  done: ->
    setTimeout => @tool.deselect()

  close: ->
    @el.style.display = 'none'

  destroy: ->
    @el.querySelector('form.identification').removeEventListener 'submit', @onSubmitIdentification, false
    @el.querySelector('form.proximity').removeEventListener 'submit', @onSubmitProximity, false
    $(@el).off()
    super

module.exports = CondorToolControls
