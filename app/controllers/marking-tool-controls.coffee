{ToolControls} = require 'marking-surface'
FauxRangeInput = require 'faux-range-input'
$ = window.jQuery

KEYS =
  return: 13
  esc: 27

class MarkingToolControls extends ToolControls
  template: require('../views/condor-tool-controls')()

  constructor: ->
    super

    @tool.on 'select', =>
      @showIdentification()

    $el = $(@el)
    $el.on 'click', 'button[name="close"]', @onClickClose
    $el.on 'input', 'input[name="tag"]', @onChangeTag
    $el.on 'change', 'input[name="tag-hidden"]', @onChangeTagHidden
    $el.on 'submit', 'form.identification', @onSubmitIdentification
    $el.on 'submit', 'form.proximity', @onSubmitProximity
    $el.on 'click', 'button[name="delete"]', @onClickDelete
    $el.on 'keydown', @onKeyDown

    proximityInput = $el.find('input[name="proximity"]').get 0
    $(proximityInput).on 'change', @onChangeProximity

    @fauxRangeInput = new FauxRangeInput proximityInput
    @on 'destroy', => @fauxRangeInput.destroy()

    setTimeout =>
      @tool.mark.set 'proximity', @fauxRangeInput.value

  onClickClose: =>
    @tool.deselect()

  onChangeTag: =>
    @tool.mark.set 'tag', @el.querySelector('input[name="tag"]').value

  onChangeTagHidden: =>
    @tool.mark.set 'tagHidden', @el.querySelector('input[name="tag-hidden"]').checked

  onSubmitIdentification: (e) =>
    e.preventDefault()
    @showProximity()

  onChangeProximity: =>
    @tool.mark.set 'proximity', @el.querySelector('input[name="proximity"]').value

  onSubmitProximity: (e) =>
    e.preventDefault()
    @done()

  onClickDelete: =>
    @tool.mark.destroy()

  onKeyDown: (e) =>
    switch e.which
      when KEYS.return
        e.preventDefault()
        $(@el).find('[type="submit"]:visible').first().click() # WTF
      when KEYS.esc
        @tool.mark.destroy()

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
    setTimeout => $(@el).find('input:visible, [tabindex]:visible').first().focus()

  render: ->
    $el = $(@el)
    $el.find('input[name="tag"]').val @tool.mark.tag
    $el.find('button[name="next"]').attr 'disabled', (not @tool.mark.tag) and (not @tool.mark.tagHidden)
    @fauxRangeInput?.value = @tool.mark.proximity

  done: ->
    setTimeout => @tool.deselect()

  destroy: ->
    @el.querySelector('form.identification').removeEventListener 'submit', @onSubmitIdentification, false
    @el.querySelector('form.proximity').removeEventListener 'submit', @onSubmitProximity, false
    $(@el).off()
    super

module.exports = MarkingToolControls
