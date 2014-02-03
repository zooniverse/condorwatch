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
ansiKeycode = require 'ansi-keycode'

KEYS = 13: 'enter', 27: 'esc'

class Classifier extends BaseController
  className: 'classifier'
  template: require '../views/classifier'

  selectedTool: null

  currentPanels: ''

  currentSubjectImage: null

  elements:
    'button[name="favorite"]': 'favoriteButton'
    '.talk-link': 'talkLink'
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

    @subjectContainer.prepend @markingSurface.el

    @markingSurface.on 'create-tool', (tool) =>
      tool.mark.on 'change', =>
        @reflectTool tool

    @markingSurface.on 'select-tool', @onSelectTool
    @markingSurface.on 'deselect-tool', @onSelectTool

    User.on 'change', @onUserChange
    Subject.on 'get-next', @onGettingNextSubject
    Subject.on 'select', @onSubjectSelect

    addEventListener 'resize', @rescale, false

  activate: ->
    @rescale()

  onUserChange: (e, user) =>
    Subject.next() unless @classification?

  onGettingNextSubject: =>
    @favoriteButton.prop 'disabled', true
    @talkLink.prop 'href', ''

  onSubjectSelect: (e, subject) =>
    @markingSurface.reset()
    @setState 'no-selection'

    @classification = new Classification {subject}
    @favoriteButton.prop 'disabled', false
    @talkLink.prop 'href', subject.talkHref()

    loadImage subject.location.standard, (@currentSubjectImage) =>
      @subjectImage.attr 'xlink:href', @currentSubjectImage.src
      @rescale()
      @markingSurface.enable()

  rescale: =>
    # NOTE: The SVG and its image are 100%x100%, so resize @markingSurface.el
    return unless @currentSubjectImage?
    heightScale = @currentSubjectImage.height / @currentSubjectImage.width
    height = @markingSurface.el.offsetWidth * heightScale
    @markingSurface.el.style.height = "#{height}px"
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
    @detailsContainer.find('input, textarea, button, select').filter(':not(.not-default):visible').first().focus()

  reflectTool: (tool) =>
    return unless tool is @selectedTool

    if tool.mark.animal?
      @animalPreview.attr 'src', translate "animals.#{tool.mark.animal}.image"
      @animalLabel.html translate "animals.#{tool.mark.animal}.label"
    else
      @animalPreview.attr 'src', '//placehold.it/100.png&text=Choose'
      @animalLabel.html '· · ·'

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

  updateClassificationMarks: ->
    # Save a copy of the marking surface's marks
    # since it will change after it resets.
    @classification.set 'marks', [@markingSurface.marks...]

  showSummary: ->
    @updateClassificationMarks()

    @el.addClass 'showing-summary'
    classificationSummary = new ClassificationSummary marks: @classification.get 'marks'
    classificationSummary.on 'destroying', =>
      @el.removeClass 'showing-summary'

    classificationSummary.el.appendTo @el

    setTimeout =>
      classificationSummary.show()

    classificationSummary

  sendClassification: ->
    @updateClassificationMarks()
    console?.log JSON.stringify @classification
    @classification.send()

  events:
    'click button[name="favorite"]': ->
      @classification.favorite = !@classification.favorite
      @favoriteButton.toggleClass 'selected', @classification.favorite

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
      classificationSummary = @showSummary()
      classificationSummary.on 'destroying', =>
        Subject.next()

    'keypress': (e) ->
      return if e.metaKey or e.ctrlKey or e.altKey
      return if e.target.nodeName.toUpperCase() in ['INPUT', 'TEXTAREA']

      key = if e.which of KEYS
        KEYS[e.which]
      else
        ansiKeycode e.which

      key = "SHIFT-#{key}" if e.shiftKey
      key = key.toUpperCase()

      target = @el.find("[title$='[#{key}]']:visible").first()
      # TODO: Label/input combos

      if target.length is 1
        e.preventDefault()
        target.focus()

        switch target.get(0).tagName.toUpperCase()
          when 'BUTTON'
            target.click()

module.exports = Classifier
