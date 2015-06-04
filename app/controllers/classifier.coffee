BaseController = require 'zooniverse/controllers/base-controller'
StackOfPages = require 'stack-of-pages'
User = require 'zooniverse/models/user'
Subject = require 'zooniverse/models/subject'
loadImage = require '../lib/load-image'
Classification = require 'zooniverse/models/classification'
MarkingSurface = require 'marking-surface'
MarkingTool = require './marking-tool'
{Tutorial} = require 'zootorial'
tutorialSteps = require '../lib/tutorial-steps'
selectTutorialSubject = require '../lib/select-tutorial-subject'
translate = require 't7e'
possibleAnimals = require '../lib/possible-animals'
ClassificationSummary = require './classification-summary'
TitleShortcutHandler = require 'title-shortcut-handler'
GoogleAnalytics = require 'zooniverse/lib/google-analytics'
$ = window.jQuery
Api = require 'zooniverse/lib/api'

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
    'button[name="finish-subject"]': 'finishSubjectButton'
    '.incomplete-marks': 'incompleteMarksWarning'
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
    'input[name="proximity"]': 'proximityRadios'
    'button[name="finish-selection"]': 'finishSelectionButton'
    '.loader': 'loader'
    '.no-more-subjects': 'noMoreSubjectsMessage'

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
      hasProximity = (mark for {mark} in @markingSurface.tools when mark.proximity?)
      sansCarcass = (mark for mark in hasProximity when mark.proximity is 'no-carcass')
      if sansCarcass.length > 0 and sansCarcass.length is hasProximity.length
        tool.mark.set 'proximity', 'no-carcass'

      tool.mark.on 'change', =>
        @reflectTool tool

    @markingSurface.on 'select-tool', @onSelectTool
    @markingSurface.on 'deselect-tool', @onSelectTool

    @markingSurface.on 'change', =>
      unless @classification.subject.tutorial
        localStorage.setItem 'currentClassification', @markingSurface.getValue()

    @loader.appendTo @markingSurface.el
    @noMoreSubjectsMessage.hide()
    @noMoreSubjectsMessage.appendTo @markingSurface.el

    @tutorial = new Tutorial
      demoLabel: translate 'span', 'tutorial.demoLabel'
      nextLabel: translate 'span', 'tutorial.nextLabel'
      doneLabel: translate 'span', 'tutorial.doneLabel'
      parent: @el.get 0
      steps: tutorialSteps
      onLoadStep: ->
        translate.refresh @el

    @targetSubjectID = ''
    @el.on StackOfPages::activateEvent, => @onActivate arguments...

    User.on 'change', @onUserChange
    Subject.on 'get-next', @onGettingNextSubject
    Subject.on 'select', if ~location.search.indexOf 'no-more-subjects=1'
      @onNoMoreSubjects
    else
      @onSubjectSelect
    Subject.on 'no-more', @onNoMoreSubjects

    addEventListener 'resize', @rescale, false
    @onSelectTool()

  isUserScientist: ->
    result = new $.Deferred
    if User.current?
      project = Api.current.get "/projects/#{Api.current.project}"
      talkUser = Api.current.get "/projects/#{Api.current.project}/talk/users/#{User.current.name}"
      $.when(project, talkUser).then (project, talkUser) =>
        projectRoles = talkUser.talk?.roles?[project.id] ? []
        details =
          project: project.id
          roles: projectRoles
          scientist: 'scientist' in projectRoles
          admin: 'admin' in projectRoles
          'srallen086': talkUser.name is 'srallen086'
        console?.log 'Can you pick your own subject?', JSON.stringify details, null, 2
        result.resolve 'scientist' in projectRoles or 'admin' in projectRoles or talkUser.name is 'srallen086'
    else
      result.resolve false
    result.promise()

  onActivate: (e) =>
    @rescale()

    @targetSubjectID = e.originalEvent.detail.subjectID
    if @targetSubjectID
      @tutorial.end()
      @getNextSubject() unless @targetSubjectID is Subject.current?.zooniverse_id

  getNextSubject: ->
    if @targetSubjectID
      @isUserScientist().then (theyAre) =>
        if theyAre
          request = Api.current.get "/projects/#{Api.current.project}/subjects/#{@targetSubjectID}"
          request.then (data) =>
            subject = new Subject data
            subject.select()
          request.fail =>
            alert "There's no subject with the ID #{@targetSubjectID}."
        else
          alert 'Sorry, only science team members can choose the subjects they classify.'
          Subject.next()
    else
      Subject.next()

  loadLocallyStoredSubject: ->
    subjectData = JSON.parse localStorage.getItem 'currentSubject'
    if subjectData?
      subject = new Subject subjectData
      subject.select()

      marks = JSON.parse localStorage.getItem 'currentClassification'
      for mark in marks ? []
        tool = @markingSurface.addTool new @markingSurface.tool
          surface: @markingSurface
          mark: new @markingSurface.tool.Mark mark

  onUserChange: (e, user) =>
    if Subject.instances?
      for subject in Subject.instances by -1
        subject.destroy() unless subject is Subject.current

    tutorialDone = user?.project?.tutorial_done

    tutorialSplit = location.search.match(/tutorial-split=(\w)/)?[1]
    tutorialSplit ?= user?.project?.splits?.tutorial

    if user
      if tutorialDone or tutorialSplit is 'c'
        @tutorial.end()
        Subject.next()
      else if tutorialSplit is 'b'
        @tutorial.first = 'prompt'
        @startTutorial()
      else if tutorialSplit is 'a'
        @tutorial.first = 'welcome'
        @startTutorial()
      else
        @loadLocallyStoredSubject()
    else
      @tutorial.first = 'welcome'
      @startTutorial()

  onGettingNextSubject: =>
    @loader.fadeIn()
    @favoriteButton.prop 'disabled', true
    @talkLink.prop 'href', ''
    @markingSurface.disable()

  onSubjectSelect: (e, subject) =>
    @noMoreSubjectsMessage.hide()
    unless subject.tutorial
      localStorage.setItem 'currentSubject', JSON.stringify subject

    @markingSurface.reset()
    @onSelectTool null

    @classification = new Classification {subject}
    if subject.zooniverse_id is @targetSubjectID
      @classification.set 'chosen_subject', true

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

      @loader.fadeOut()

      if subject.tutorial
        @tutorial.start()

  onNoMoreSubjects: =>
    @loader.fadeOut()
    @noMoreSubjectsMessage.show()

  rescale: =>
    # NOTE: The SVG and its image are 100%x100%, so resize @markingSurface.el
    return unless @currentSubjectImage?
    heightScale = @currentSubjectImage.height / @currentSubjectImage.width
    height = @markingSurface.el.offsetWidth * heightScale
    @markingSurface.el.style.height = "#{height}px"
    tool.render() for tool in @markingSurface.tools

  startTutorial: ->
    selectTutorialSubject()

  onSelectTool: (@selectedTool) =>
    if @selectedTool?
      @deleteMarkButton.show()

      if @selectedTool.mark.animal is 'condor'
        @setState 'summary', 'condor-details', 'proximity-details', 'finish-selection'
      else if @selectedTool.mark.animal is 'raven'
        @setState 'summary', 'finish-selection'
      else if @selectedTool.mark.animal is 'carcass'
        @setState 'summary', 'carcass-hint', 'finish-selection'
      else if @selectedTool.mark.animal is 'other'
        @setState 'summary', 'talk-reminder', 'finish-selection'
      else if @selectedTool.mark.animal?
        @setState 'summary', 'proximity-details', 'finish-selection'
      else
        @setState 'summary', 'what-kind'

      @reflectTool @selectedTool

    else
      @deleteMarkButton.hide()
      @setState 'no-selection'

      @checkForIncompleteMarks()

  checkForIncompleteMarks: ->
    allComplete = (mark for mark in @markingSurface.marks when not mark.isValid()).length is 0
    # @finishSubjectButton.prop 'disabled', not allComplete
    @incompleteMarksWarning.toggle not allComplete

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
      @animalPreview.attr 'src', '//placeholdit.imgix.net/~text?txtsize=19&txt=Choose&w=150&h=150'
      @animalLabel.html '· · ·'

    @animalButtons.removeClass 'selected'
    @animalButtons.filter("[value='#{tool.mark.animal}']").addClass 'selected'
    @confirmAnimalButton.prop 'disabled', not tool.mark.animal?

    @labelInput.val tool.mark.label || ''

    @colorButtons.removeClass 'selected'
    @colorButtons.filter("[value='#{tool.mark.color}']").addClass 'selected'

    valuedDotsButtons = @dotsButtons.filter '.non-zero'
    valuedDotsButtons.removeClass 'selected'
    valuedDotsButtons.slice(0, tool.mark.dots).addClass 'selected'

    @underlinedCheckbox.prop 'checked', !!tool.mark.underlined
    @juvenileCheckbox.prop 'checked', !!tool.mark.juvenile
    @adultCheckbox.prop 'checked', !!tool.mark.adult

    @proximityRadios.prop 'checked', false
    @proximityRadios.filter("[value='#{tool.mark.proximity}']").prop 'checked', true

    @finishSelectionButton.prop 'disabled', not tool.mark.isValid()

  updateClassificationMarks: ->
    # Save a copy of the marking surface's marks
    # since it will change after it resets.
    @classification.set 'marks', [@markingSurface.marks...]

  showSummary: ->
    @updateClassificationMarks()

    @el.addClass 'showing-summary'

    classificationSummary = new ClassificationSummary {@classification}

    classificationSummary.on 'destroying', =>
      @el.removeClass 'showing-summary'

    classificationSummary.el.appendTo @el

    setTimeout =>
      classificationSummary.show()

    classificationSummary

  sendClassification: ->
    @updateClassificationMarks()
    console?.log 'Sent classification', JSON.stringify @classification
    @classification.send()
    localStorage.removeItem 'currentClassification'
    localStorage.removeItem 'currentSubject'

  events:
    'click button[name="favorite"]': ->
      @classification.favorite = !@classification.favorite
      @favoriteButton.toggleClass 'selected', @classification.favorite

    'click button[name="start-tutorial"]': ->
      @tutorial.first = 'welcome'
      @startTutorial()
      GoogleAnalytics.current?.event 'Tutorial', 'Start manually'

    'click button[name="delete-mark"]': ->
      @selectedTool.mark.destroy()
      @checkForIncompleteMarks()

    'click button[name="unchoose-animal"]': ->
      @selectedTool.mark.set 'animal', null
      @onSelectTool @selectedTool

    'click button[name="animal"]': (e) ->
      @selectedTool.mark.set e.currentTarget.name, e.currentTarget.value

      # Default to zero dots.
      if e.currentTarget.value is 'condor'
        @selectedTool.mark.set 'dots', @selectedTool.mark.dots ? 0

    'click button[name="confirm-animal"]': ->
      @onSelectTool @selectedTool

    'input input[name="label"]': (e) ->
      @selectedTool.mark.set e.currentTarget.name, e.currentTarget.value

    'click button[name="color"]': (e) ->
      @selectedTool.mark.set e.currentTarget.name, e.currentTarget.value

    'click button[name="dots"]': (e) ->
      value = parseFloat e.currentTarget.value
      @selectedTool.mark.set e.currentTarget.name, value

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

    'change input[name="proximity"]': (e) ->
      @selectedTool.mark.set 'proximity', e.currentTarget.value

    'click button[name="finish-selection"]': ->
      @markingSurface.selection.deselect()

    'click button[name="finish-subject"]': ->
      classificationSummary = @showSummary()

      classificationSummary.on 'guess', (e, ids) =>
        @classification.set 'guessed_ids', ids
        @sendClassification()

      classificationSummary.on 'destroying', =>
        @targetSubjectID = ''
        Subject.next()

    'keydown': TitleShortcutHandler

  @::events[Tutorial::abortEvent] = ->
    GoogleAnalytics.current?.event 'Tutorial', 'Abort'

module.exports = Classifier
