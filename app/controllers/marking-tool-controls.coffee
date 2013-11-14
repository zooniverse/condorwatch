{ToolControls} = require 'marking-surface'
BaseController = require 'zooniverse/controllers/base-controller'
FauxRangeInput = require 'faux-range-input'

KEYS =
  return: 13
  esc: 27

class MarkingToolControlsController extends BaseController
  template: require '../views/condor-tool-controls'

  tool: null

  state: ''

  elements:
    'input[name="selected-animal"]': 'selectedAnimalRadios'
    'input[name="tag"]': 'tagInput'
    'input[name="cant-see-tag"]': 'cantSeeTagCheckbox'
    'input[name="proximity"]': 'proximityInput'
    'input[name="is-on-carcass"]': 'isOnCarcassRadios'

  constructor: ->
    super

    fauxRangeInputs = FauxRangeInput.find @el.get 0
    @on 'destroy', -> fauxRangeInputs.shift().destroy() until fauxRangeInputs.length is 0

    @tool.mark.on 'change', (property, value) =>
      switch property
        when 'animal'
          @selectedAnimalRadios.prop 'checked', false
          @selectedAnimalRadios.filter("[value='#{value}']").prop 'checked', true

        when 'tag'
          @tagInput.val value

        when 'cantSeeTag'
          @tagInput.prop 'disabled', value
          @cantSeeTagCheckbox.prop 'checked', value

        when 'proximity'
          @proximityInput.val value

        when 'isOnCarcass'
          @isOnCarcassRadios.prop 'checked', false
          @isOnCarcassRadios.filter("[value='#{value}']").prop 'checked', true

    @setState 'whatKind'

  events:
    'change input[name="selected-animal"]': (e) ->
      @tool.mark.set 'animal', @selectedAnimalRadios.filter(':checked').val()

    'input input[name="tag"]': (e) ->
      @tool.mark.set 'tag', e.currentTarget.value

    'change input[name="cant-see-tag"]': (e) ->
      @tool.mark.set 'cantSeeTag', e.currentTarget.checked

    'change input[name="proximity"]': (e) ->
      @tool.mark.set 'proximity', e.currentTarget.value

    'change input[name="is-on-carcass"]': (e) ->
      @tool.mark.set 'isOnCarcass', @isOnCarcassRadios.filter(':checked').val()

    'click button[name="delete"]': ->
      @tool.mark.destroy()

    'click button[name="back"]': ->
      @setState 'what-kind'

    'click button[name="next"]': ->
      @setState if @tool.mark.animal is 'condor'
        'condorDetails'
      else
        'nonCondorDetails'

    'click button[name="done"]': ->
      @tool.deselect()

  setState: (newState) ->
    if @state
      @states[@state]?.exit.call @
    else
      exit.call @ for state, {exit} of @states when state isnt newState

    @states[newState]?.enter.call @
    @state = newState

  states:
    whatKind:
      enter: ->
        @el.find('.what-kind').show()
        @el.find('button[name="next"]').show()

      exit: ->
        @el.find('.what-kind').hide()
        @el.find('button[name="next"]').hide()

    condorDetails:
      enter: ->
        @el.find('.condor-details').show()
        @el.find('button[name="done"]').show()

      exit: ->
        @el.find('.condor-details').hide()
        @el.find('button[name="done"]').hide()

    nonCondorDetails:
      enter: ->
        @el.find('.non-condor-details').show()
        @el.find('button[name="done"]').show()

      exit: ->
        @el.find('.non-condor-details').hide()
        @el.find('button[name="done"]').hide()

class MarkingToolControls extends ToolControls
  constructor: ->
    super

    controller = new MarkingToolControlsController tool: @tool
    @el.appendChild controller.el.get 0
    @on 'destroy', -> controller.destroy()

module.exports = MarkingToolControls
