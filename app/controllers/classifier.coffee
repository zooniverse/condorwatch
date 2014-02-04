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
TitleShortcutHandler = require 'title-shortcut-handler'

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
    'button[name="delete-mark"]': 'deleteMarkButton'
    'button[name="unchoose-animal"]': 'unchooseButton'
    '.animal-preview': 'animalPreview'
    '.animal-label': 'animalLabel'
    'button[name="animal"]': 'animalButtons'
    'button[name="confirm-animal"]': 'confirmAnimalButton'
    'input[name="label"]': 'labelInput'
    'button[name="color"]': 'colorButtons'
    'button[name="dots"]': 'dotsButtons'
    'input[name="underlined"]': 'underlinedCheckbox'
    'input[name="juvenile"]': 'juvenileCheckbox'
    'input[name="adult"]': 'adultCheckbox'
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

    @markingSurface.on 'change', =>
      localStorage.setItem 'currentClassification', @markingSurface.getValue()

    User.on 'change', @onUserChange
    Subject.on 'get-next', @onGettingNextSubject
    Subject.on 'select', @onSubjectSelect

    addEventListener 'resize', @rescale, false
    @onSelectTool()

    subjectData = JSON.parse localStorage.getItem 'currentSubject'
    if subjectData?
      subject = new Subject subjectData
      subject.select()

      marks = JSON.parse localStorage.getItem 'currentClassification'
      for mark in marks ? []
        tool = @markingSurface.addTool new @markingSurface.tool
          surface: @markingSurface
          mark: new @markingSurface.tool.Mark mark

  activate: ->
    @rescale()

  onUserChange: (e, user) =>
    for subject in Subject.instances
      subject.destroy() unless subject is Subject.current

    Subject.next() unless @classification?

  onGettingNextSubject: =>
    @favoriteButton.prop 'disabled', true
    @talkLink.prop 'href', ''

  onSubjectSelect: (e, subject) =>
    localStorage.setItem 'currentSubject', JSON.stringify subject

    @markingSurface.reset()
    @onSelectTool null

    @classification = new Classification {subject}
    @favoriteButton.prop 'disabled', false
    @talkLink.prop 'href', subject.talkHref()

    loadImage subject.location.standard, (@currentSubjectImage) =>
      @subjectImage.attr 'xlink:href', @currentSubjectImage.src
      @rescale()
      @markingSurface.enable()

      for tool in @markingSurface.tools
        tool.href = @currentSubjectImage.src
        tool.redraw()
        tool.deselect()

  rescale: =>
    # NOTE: The SVG and its image are 100%x100%, so resize @markingSurface.el
    return unless @currentSubjectImage?
    heightScale = @currentSubjectImage.height / @currentSubjectImage.width
    height = @markingSurface.el.offsetWidth * heightScale
    @markingSurface.el.style.height = "#{height}px"
    tool.render() for tool in @markingSurface.tools

  onSelectTool: (@selectedTool) =>
    if @selectedTool?
      @deleteMarkButton.show()

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
      @deleteMarkButton.hide()
      @setState 'no-selection'

  setState: (@currentPanels...) ->
    panelElements = @el.find '.state'
    toShow = panelElements.filter @currentPanels.map((className) -> ".#{className}").join ','

    panelElements.hide()
    toShow.show()
    @el.attr 'data-state', @currentPanels.join ' '
    focusables = @detailsContainer.find 'input, button'
    focusables = focusables.filter ':visible'
    focusables = focusables.filter ':not(.not-default)'
    focusables.first().focus()

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
    @adultCheckbox.prop 'checked', !!tool.mark.adult

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

    'click button[name="delete-mark"]': ->
      @selectedTool.mark.destroy()

    'click button[name="unchoose-animal"]': ->
      @selectedTool.mark.set 'animal', null
      @onSelectTool @selectedTool

    'click button[name="animal"]': (e) ->
      @selectedTool.mark.set e.currentTarget.name, e.currentTarget.value

    'click button[name="confirm-animal"]': ->
      @onSelectTool @selectedTool

    'input input[name="label"]': (e) ->
      @selectedTool.mark.set e.currentTarget.name, e.currentTarget.value

    'click button[name="color"]': (e) ->
      @selectedTool.mark.set e.currentTarget.name, e.currentTarget.value

    'click button[name="dots"]': (e) ->
      @selectedTool.mark.set e.currentTarget.name, parseFloat e.currentTarget.value

    'change input[name="underlined"]': (e) ->
      @selectedTool.mark.set e.currentTarget.name, e.currentTarget.checked

    'change input[name="juvenile"]': (e) ->
      @selectedTool.mark.set e.currentTarget.name, e.currentTarget.checked
      if e.currentTarget.checked
        @selectedTool.mark.set 'adult', false

    'change input[name="adult"]': (e) ->
      @selectedTool.mark.set e.currentTarget.name, e.currentTarget.checked
      if e.currentTarget.checked
        @selectedTool.mark.set 'juvenile', false

    'click button[name="proximity"]': (e) ->
      @selectedTool.mark.set 'proximity', e.currentTarget.value

    'click button[name="finish-selection"]': ->
      @markingSurface.selection.deselect()

    'click button[name="finish-subject"]': ->
      @sendClassification()
      classificationSummary = @showSummary()
      classificationSummary.on 'destroying', =>
        Subject.next()

    'keydown': TitleShortcutHandler

module.exports = Classifier
