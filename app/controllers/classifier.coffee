BaseController = require 'zooniverse/controllers/base-controller'
User = require 'zooniverse/models/user'
Subject = require 'zooniverse/models/subject'
loadImage = require '../lib/load-image'
Classification = require 'zooniverse/models/classification'
MarkingSurface = require 'marking-surface'
MarkingTool = require './marking-tool'
translate = require 't7e'
possibleAnimals = require '../lib/possible-animals'
ClassificationSummary = require './classification-summary'

KEYS =
  return: 13
  esc: 27
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
  6: 54
  7: 55
  8: 56
  9: 57

class Classifier extends BaseController
  className: 'classifier'
  template: require '../views/classifier'

  selectedTool: null

  currentPanels: ''

  currentSubjectImage: null

  elements:
    '.image-container': 'subjectContainer'
    '.details-editor': 'detailsContainer'
    'button[name="unchoose-animal"]': 'unchooseButton'
    '.animal-preview': 'animalPreview'
    '.animal-label': 'animalLabel'
    'button[name="choose-animal"]': 'animalButtons'
    'button[name="confirm-animal"]': 'confirmAnimalButton'
    'input[name="label"]': 'labelInput'
    'button[name="tag-color"]': 'colorButtons'
    'button[name="dots"]': 'dotsButtons'
    'input[name="underlined"]': 'underlinedCheckbox'
    'input[name="juvenile"]': 'juvenileCheckbox'
    'button[name="proximity"]': 'proximityButtons'
    'button[name="finish-selection"]': 'finishSelectionButton'

  constructor: ->
    super
    window.classifier = @ if +location.port > 1023

    @markingSurface = new MarkingSurface
      tool: MarkingTool
      tabIndex: -1

    @subjectImage = @markingSurface.addShape 'image',
      width: '100%'
      height: '100%'
      preserveAspectRatio: 'none'

    @subjectContainer.append @markingSurface.el

    @markingSurface.on 'create-tool', (tool) =>
      tool.mark.on 'change', =>
        @reflectTool tool

    @markingSurface.on 'select-tool', @onSelectTool
    @markingSurface.on 'deselect-tool', @onSelectTool

    User.on 'change', @onUserChange
    Subject.on 'select', @onSubjectSelect

    addEventListener 'resize', @rescale, false

  activate: ->
    @rescale()

  onUserChange: (e, user) =>
    Subject.next() unless @classification?

  onSubjectSelect: (e, subject) =>
    @markingSurface.reset()
    @setState 'no-selection'

    @classification = new Classification {subject}

    loadImage subject.location.standard, (@currentSubjectImage) =>
      @subjectImage.attr 'xlink:href', @currentSubjectImage.src
      @rescale()
      @markingSurface.enable()

  rescale: =>
    return unless @currentSubjectImage?
    heightScale = @currentSubjectImage.height / @currentSubjectImage.width
    height = @markingSurface.el.offsetWidth * heightScale
    @markingSurface.svg.attr 'height', height
    tool.render() for tool in @markingSurface.tools

  onSelectTool: (@selectedTool) =>
    if @selectedTool?
      if @selectedTool.mark.animal is 'condor'
        @setState 'summary', 'condor-details', 'proximity-details', 'finish-selection'
      else if @selectedTool.mark.animal is 'carcassOrScale'
        @setState 'summary', 'finish-selection'
      else if @selectedTool.mark.animal?
        @setState 'summary', 'proximity-details', 'finish-selection'
      else
        @setState 'summary', 'what-kind'

      @reflectTool @selectedTool

    else
      @setState 'no-selection'

  setState: (@currentPanels...) ->
    panelElements = @el.find '.state'
    toShow = panelElements.filter @currentPanels.map((className) -> ".#{className}").join ','

    panelElements.hide()
    toShow.show()
    @el.attr 'data-state', @currentPanels.join ' '
    @detailsContainer.find('input, textarea, button, select').filter(':visible').first().focus()

  reflectTool: (tool) =>
    return unless tool is @selectedTool

    if tool.mark.animal?
      @animalPreview.attr 'src', translate "animals.#{tool.mark.animal}.image"
      @animalLabel.html translate "animals.#{tool.mark.animal}.label"
    else
      @animalPreview.attr 'src', '//placehold.it/100.png&text=Choose'
      @animalLabel.html ''

    @animalButtons.removeClass 'selected'
    @animalButtons.filter("[value='#{tool.mark.animal}']").addClass 'selected'

    @confirmAnimalButton.prop 'disabled', not tool.mark.animal?

    @labelInput.val tool.mark.label || ''

    @colorButtons.removeClass 'selected'
    @colorButtons.filter("[value='#{tool.mark.color}']").addClass 'selected'

    valuedDotsButtons = @dotsButtons.filter '[value]'
    valuedDotsButtons.removeClass 'selected'
    valuedDotsButtons.slice(0, tool.mark.dots || 0).addClass 'selected'

    @underlinedCheckbox.prop 'checked', !!tool.mark.underlined
    @juvenileCheckbox.prop 'checked', !!tool.mark.juvenile

    @proximityButtons.removeClass 'selected'
    @proximityButtons.filter("[value='#{tool.mark.proximity}']").addClass 'selected'

    @finishSelectionButton.prop 'disabled', tool.mark.animal isnt 'carcassOrScale' and not tool.mark.proximity?

  showSummary: (onDestroySummary) ->
    @classification.set 'marks', [@markingSurface.marks...]

    classificationSummary = new ClassificationSummary {@classification}
    classificationSummary.el.appendTo @el
    @el.addClass 'showing-summary'

    classificationSummary.on 'destroying', =>
      @el.removeClass 'showing-summary'
      onDestroySummary?()

    setTimeout =>
      classificationSummary.show()

  sendClassification: ->
    # Save a copy of the marking surface's marks
    # since it will change after it resets.
    @classification.set 'marks', [@markingSurface.marks...]
    console?.log JSON.stringify @classification
    @classification.send()

  events:
    'click button[name="unchoose-animal"]': ->
      @selectedTool.mark.set 'animal', null
      @onSelectTool @selectedTool

    'click button[name="choose-animal"]': (e) ->
      @selectedTool.mark.set 'animal', e.currentTarget.value

    'click button[name="confirm-animal"]': ->
      @onSelectTool @selectedTool

    'input input[name="label"]': (e) ->
      @selectedTool.mark.set 'label', e.currentTarget.value

    'click button[name="tag-color"]': (e) ->
      @selectedTool.mark.set 'color', e.currentTarget.value

    'click button[name="dots"]': (e) ->
      @selectedTool.mark.set 'dots', parseFloat e.currentTarget.value

    'change input[name="underlined"]': (e) ->
      @selectedTool.mark.set 'underlined', e.currentTarget.checked

    'change input[name="juvenile"]': (e) ->
      @selectedTool.mark.set 'juvenile', e.currentTarget.checked

    'click button[name="proximity"]': (e) ->
      @selectedTool.mark.set 'proximity', e.currentTarget.value

    'click button[name="finish-selection"]': ->
      @markingSurface.selection.deselect()

    'click button[name="finish-subject"]': ->
      @sendClassification()
      @showSummary ->
        Subject.next()

    'keydown .details-editor': (e) ->
      return if e.target.type is 'text'

      if @selectedTool?
        if e.which is KEYS.return
          @detailsContainer.find('.default:visible').first().click()
        else if 'what-kind' in @currentPanels
          switch e.which
            when KEYS[1] then @selectedTool.mark.set 'animal', possibleAnimals[0]
            when KEYS[2] then @selectedTool.mark.set 'animal', possibleAnimals[1]
            when KEYS[3] then @selectedTool.mark.set 'animal', possibleAnimals[2]
            when KEYS[4] then @selectedTool.mark.set 'animal', possibleAnimals[3]
            when KEYS[5] then @selectedTool.mark.set 'animal', possibleAnimals[4]
            when KEYS[6] then @selectedTool.mark.set 'animal', possibleAnimals[5]
            when KEYS.esc then @selectedTool.mark.destroy()
            else dontPreventDefault = true
        else
          switch e.which
            when KEYS.q then @selectedTool.mark.set 'color', 'black'
            when KEYS.w then @selectedTool.mark.set 'color', 'white'
            when KEYS.e then @selectedTool.mark.set 'color', 'red'
            when KEYS.r then @selectedTool.mark.set 'color', 'orange'
            when KEYS.t then @selectedTool.mark.set 'color', 'yellow'
            when KEYS.y then @selectedTool.mark.set 'color', 'green'
            when KEYS.u then @selectedTool.mark.set 'color', 'blue'
            when KEYS.i then @selectedTool.mark.set 'color', 'purple'

            when KEYS[0] then @selectedTool.mark.set 'dots', 0
            when KEYS[1] then @selectedTool.mark.set 'dots', 1
            when KEYS[2] then @selectedTool.mark.set 'dots', 2
            when KEYS[3] then @selectedTool.mark.set 'dots', 3
            when KEYS[4] then @selectedTool.mark.set 'dots', 4
            when KEYS[5] then @selectedTool.mark.set 'dots', 5

            when KEYS.esc then @selectedTool.mark.set 'animal', null; @onSelectTool @selectedTool
            else dontPreventDefault = true

      e.preventDefault() unless dontPreventDefault

module.exports = Classifier
