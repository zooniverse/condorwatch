{ToolControls} = require 'marking-surface'
BaseController = require 'zooniverse/controllers/base-controller'
$ = window.jQuery
FauxRangeInput = require 'faux-range-input'
translate = require 't7e'

KEYS =
  return: 13
  esc: 27
  minus: 189
  plus: 187
  slash: 191
  q: 81
  w: 87
  e: 69
  r: 82
  t: 84
  y: 89
  u: 85
  i: 73
  0: 48
  1: 49
  2: 50
  3: 51
  4: 52
  5: 53

class MarkingToolControlsController extends BaseController
  className: 'marking-tool-controls-controller'
  template: require '../views/marking-tool-controls'

  tool: null

  state: ''

  elements:
    'img.selected-animal-example': 'selectedAnimalImage'
    '.selected-animal-label': 'selectedAnimalLabel'
    '[name="choose-animal"]': 'animalChoiceButtons'
    'input[name="label"]': 'labelInput'
    'button[name="tag-color-toggle"]': 'tagColorToggle'
    'button[name="tag-color"]': 'tagColorButtons'
    'button[name="dots"]': 'dotsButtons'
    'input[name="underlined"]': 'underlinedCheckbox'
    'input[name="proximity"]': 'proximityInput'
    'input[name="is-on-carcass"]': 'isOnCarcassRadios'

  constructor: ->
    super

    fauxRangeInputs = FauxRangeInput.find @el.get 0
    @on 'destroy', -> fauxRangeInputs.shift().destroy() until fauxRangeInputs.length is 0

    @tool.mark.on 'change', (property, value) =>
      switch property
        when 'animal'
          @selectedAnimalImage.attr 'src', translate "animals.#{value}.image"
          @selectedAnimalLabel.html translate "animals.#{value}.label"
          @animalChoiceButtons.removeClass 'selected'
          @animalChoiceButtons.filter("[value='#{value}']").addClass 'selected'

          if value is 'condor'
            @tool.mark.set 'isOnCarcass', null
          else
            @tool.mark.set 'label', null
            @tool.mark.set 'color', null
            @tool.mark.set 'dots', null
            @tool.mark.set 'underlined', null
            @tool.mark.set 'proximity', null

        when 'tag'
          @tagInput.val value

        when 'color'
          @tagColorButtons.removeClass 'selected'
          if value?
            @tagColorToggle.attr 'data-tag-color', value
            @tagColorButtons.filter("[value='#{value}']").addClass 'selected'
          else
            @tagColorToggle.attr 'data-tag-color', null

        when 'dots'
          @dotsButtons.removeClass 'selected'
          @dotsButtons.slice(0, value + 1).addClass 'selected'

        when 'underlined'
          @underlinedCheckbox.prop 'checked', value

        when 'proximity'
          @proximityInput.val value

        when 'isOnCarcass'
          @isOnCarcassRadios.prop 'checked', false
          @isOnCarcassRadios.filter("[value='#{value}']").prop 'checked', true

      @el.find('button[name="next"]').prop 'disabled', not @tool.mark.animal
      # @el.find('button[name="done-with-condor"]').prop 'disabled', not @tool.mark.label
      @el.find('button[name="done-with-non-condor"]').prop 'disabled', not @tool.mark.isOnCarcass?

    @setState 'whatKind'

  events:
    'click button[name="to-select"]': ->
      @setState 'whatKind'

    'click [name="choose-animal"]': (e) ->
      @tool.mark.set 'animal', e.currentTarget.value

    'input input[name="label"]': (e) ->
      @tool.mark.set 'label', e.currentTarget.value

    'click button[name="tag-color"]': (e) ->
      @tool.mark.set 'color', e.target.value || null

    'click button[name="dots"]': (e) ->
      @tool.mark.set 'dots', parseFloat e.currentTarget.value

    'change input[name="underlined"]': (e) ->
      @tool.mark.set 'underlined', @underlinedCheckbox.prop 'checked'

    'change input[name="proximity"]': (e) ->
      @tool.mark.set 'proximity', e.currentTarget.value

    'change input[name="is-on-carcass"]': (e) ->
      @tool.mark.set 'isOnCarcass', @isOnCarcassRadios.filter(':checked').val()

    'click button[name="delete"]': ->
      @tool.mark.destroy()

    'click button[name="next"]': ->
      @setState if @tool.mark.animal is 'condor'
        'condorDetails'
      else
        'nonCondorDetails'

    'click button[name^="done-with-"]': ->
      @tool.deselect()

    'keydown .condor-details': (e) ->
      return if e.target.type is 'text'

      if @state is 'condorDetails'
        switch e.which
          when KEYS[0] then @tool.mark.set 'dots', 0
          when KEYS[1] then @tool.mark.set 'dots', 1
          when KEYS[2] then @tool.mark.set 'dots', 2
          when KEYS[3] then @tool.mark.set 'dots', 3
          when KEYS[4] then @tool.mark.set 'dots', 4
          when KEYS[5] then @tool.mark.set 'dots', 5

          when KEYS.q then @tool.mark.set 'color', 'black'
          when KEYS.w then @tool.mark.set 'color', 'white'
          when KEYS.e then @tool.mark.set 'color', 'red'
          when KEYS.r then @tool.mark.set 'color', 'orange'
          when KEYS.t then @tool.mark.set 'color', 'yellow'
          when KEYS.y then @tool.mark.set 'color', 'green'
          when KEYS.u then @tool.mark.set 'color', 'blue'
          when KEYS.i then @tool.mark.set 'color', 'purple'

          when KEYS.minus then @tool.mark.set 'proximity', Math.max 0, (@tool.mark.proximity ? 0.5) - 0.25
          when KEYS.plus then @tool.mark.set 'proximity', Math.min 1, (@tool.mark.proximity ? 0.5) + 0.25

      switch e.which
        when KEYS.return then @el.find('footer button.default:visible').first().click()
        when KEYS.esc then @el.find('footer button.cancel:visible').first().click()
        else
          dontPreventDefault = true

      e.preventDefault() unless dontPreventDefault

  setState: (newState) ->
    if @state
      @states[@state]?.exit.call @
    else
      exit.call @ for state, {exit} of @states when state isnt newState

    @state = newState
    @states[@state]?.enter.call @
    @el.attr 'data-state', @state

    setTimeout =>
      @el.find('a, button, input, textarea, select').filter('section *:visible').first().focus()

  states:
    whatKind:
      enter: ->
        @el.find('button[name="to-select"]').addClass 'hidden'
        @selectedAnimalImage.addClass 'major'
        @selectedAnimalLabel.addClass 'hidden'
        @el.find('.what-kind').show()
        @el.find('button[name="next"]').show()

      exit: ->
        @el.find('button[name="to-select"]').removeClass 'hidden'
        @selectedAnimalImage.removeClass 'major'
        @selectedAnimalLabel.removeClass 'hidden'
        @el.find('.what-kind').hide()
        @el.find('button[name="next"]').hide()

    condorDetails:
      enter: ->
        @el.find('.condor-details').show()
        @el.find('button[name="done-with-condor"]').show()

      exit: ->
        @el.find('.condor-details').hide()
        @el.find('button[name="done-with-condor"]').hide()

    nonCondorDetails:
      enter: ->
        @el.find('.non-condor-details').show()
        @el.find('button[name="done-with-non-condor"]').show()

      exit: ->
        @el.find('.non-condor-details').hide()
        @el.find('button[name="done-with-non-condor"]').hide()


class MarkingToolControls extends ToolControls
  constructor: ->
    super

    controller = new MarkingToolControlsController tool: @tool
    @el.appendChild controller.el.get 0
    @on 'destroy', -> controller.destroy()

module.exports = MarkingToolControls
