{ToolControls} = require 'marking-surface'
BaseController = require 'zooniverse/controllers/base-controller'
$ = window.jQuery
Dropdown = require 'zooniverse/controllers/dropdown'
FauxRangeInput = require 'faux-range-input'
translate = require 't7e'

KEYS =
  return: 13
  esc: 27

class MarkingToolControlsController extends BaseController
  className: 'marking-tool-controls-controller'
  template: require '../views/marking-tool-controls'

  tool: null

  state: ''

  elements:
    'img.selected-animal-example': 'selectedAnimalImage'
    '.selected-animal-label': 'selectedAnimalLabel'
    '[name="choose-animal"]': 'animalChoiceButtons'
    'input[name="tag"]': 'tagInput'
    'button[name="dots"]': 'dotsButtons'
    'input[name="proximity"]': 'proximityInput'
    'input[name="is-on-carcass"]': 'isOnCarcassRadios'

  constructor: ->
    super

    fauxRangeInputs = FauxRangeInput.find @el.get 0
    @on 'destroy', -> fauxRangeInputs.shift().destroy() until fauxRangeInputs.length is 0

    @colorMenu = new Dropdown
      button: @el.find('button[name="tag-color-toggle"]').get 0
      menu: @el.find('.tag-color-menu').get 0
    @on 'destroy', => @colorMenu.destroy()

    $(@colorMenu.menu).on 'click button[name="tag-color"]', (e) =>
      @tool.mark.set 'color', e.target.value || null
      @colorMenu.close()

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
            @tool.mark.set 'tag', null
            @tool.mark.set 'cantSeeTag', null
            @tool.mark.set 'proximity', null

        when 'tag'
          @tagInput.val value

        when 'color'
          # TODO: Display the color.

        when 'dots'
          @dotsButtons.removeClass 'selected'
          @dotsButtons.slice(0, value).addClass 'selected'

        when 'proximity'
          @proximityInput.val value

        when 'isOnCarcass'
          @isOnCarcassRadios.prop 'checked', false
          @isOnCarcassRadios.filter("[value='#{value}']").prop 'checked', true

      @el.find('button[name="next"]').prop 'disabled', not @tool.mark.animal
      @el.find('button[name="done-with-condor"]').prop 'disabled', not @tool.mark.tag and not @tool.mark.cantSeeTag
      @el.find('button[name="done-with-non-condor"]').prop 'disabled', not @tool.mark.isOnCarcass?

    @setState 'whatKind'

  events:
    'click button[name="to-select"]': ->
      @setState 'whatKind'

    'click [name="choose-animal"]': (e) ->
      @tool.mark.set 'animal', e.currentTarget.value

    'input input[name="tag"]': (e) ->
      @tool.mark.set 'tag', e.currentTarget.value

    'click button[name="dots"]': (e) ->
      @tool.mark.set 'dots', parseFloat e.currentTarget.value

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

    'keydown': (e) ->
      switch e.which
        when KEYS.return then @el.find('footer button.default:visible').first().click()
        when KEYS.esc then @el.find('footer button.cancel:visible').first().click()

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
