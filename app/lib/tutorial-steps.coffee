translate = require 't7e'
GoogleAnalytics = require 'zooniverse/lib/google-analytics'

module.exports =
  prompt:
    header: translate 'span.content', 'tutorial.prompt.header'
    content: translate 'div', 'tutorial.prompt.content'
    nextLabel: translate 'span', 'tutorial.prompt.nextLabel'

    onLoad: ->
      acceptButton = @footer.querySelector '.zootorial-next'
      acceptButton.addEventListener 'click', ->
        GoogleAnalytics.current?.event 'Tutorial', 'Accept at prompt'

      rejectButton = @createElement 'button.reject-tutorial', @footer
      @footer.appendChild rejectButton.previousElementSibling # Reorder
      rejectButton.innerHTML = translate 'span', 'tutorial.prompt.rejectLabel'
      rejectButton.onclick = =>
        GoogleAnalytics.current?.event 'Tutorial', 'Reject at prompt'
        @triggerEvent 'reject'
        @end()

    next: 'welcome'

  welcome:
    header: translate 'span.content', 'tutorial.welcome.header'
    content: translate 'div', 'tutorial.welcome.content'
    next: 'introduceTask'

  introduceTask:
    header: translate 'span.content', 'tutorial.introduceTask.header'
    content: translate 'div', 'tutorial.introduceTask.content'
    next: 'markCondor'

  markCondor:
    header: translate 'span.content', 'tutorial.markCondor.header'
    content: translate 'div', 'tutorial.markCondor.content'
    instruction: translate 'div', 'tutorial.markCondor.instruction'
    attachment: ['center', 'top', '.subject .marking-surface', 420 / 640, 160 / 360]
    arrow: 'up'
    next:
      'tool-initial-release': 'denoteCondor'

  denoteCondor:
    header: translate 'span.content', 'tutorial.denoteCondor.header'
    content: translate 'div', 'tutorial.denoteCondor.content'
    instruction: translate 'div', 'tutorial.denoteCondor.instruction'
    attachment: ['right', 'middle', 'button[name="animal"][value="condor"]', 'left', 'middle']
    arrow: 'right'
    actionable: 'button[name="animal"][value="condor"], button[name="confirm-animal"]'
    next:
      'click button[name="animal"][value="condor"]': ->
        @attach ['right', 'middle', 'button[name="confirm-animal"]', 'left', 'middle']
        false

      'click button[name="confirm-animal"]': 'tagDetails'

  tagDetails:
    header: translate 'span.content', 'tutorial.tagDetails.header'
    content: translate 'div', 'tutorial.tagDetails.content'
    attachment: ['right', '0.75', '.condor-details.state', 'left', 'top']
    arrow: 'right'
    block: 'button[name="finish-selection"]'
    next: 'markZoom'

  markZoom:
    header: translate 'span.content', 'tutorial.markZoom.header'
    content: translate 'div', 'tutorial.markZoom.content'
    attachment: ['center', 'bottom', '.marking-surface button[name="toggle"]', 'center', 'top']
    arrow: 'down'
    block: 'button[name="finish-selection"]'
    next: 'markDelete'

  markDelete:
    header: translate 'span.content', 'tutorial.markDelete.header'
    content: translate 'div', 'tutorial.markDelete.content'
    attachment: ['right', 'middle', 'button[name="delete-mark"]', 'left', 'middle']
    arrow: 'right'
    block: 'button[name="delete-mark"], button[name="finish-selection"]'
    next: 'completeMark'

  completeMark:
    header: translate 'span.content', 'tutorial.completeMark.header'
    content: translate 'div', 'tutorial.completeMark.content'
    instruction: translate 'div', 'tutorial.completeMark.instruction'
    attachment: ['right', 'middle', 'button[name="proximity"][value="within-reach"]', 'left', 'middle']
    arrow: 'right'
    actionable: 'button[name="proximity"][value="within-reach"], button[name="finish-selection"]'
    next:
      'click button[name="proximity"][value="within-reach"]': ->
        @attach ['right', 'middle', 'button[name="finish-selection"]', 'left', 'middle']
        false

      'click button[name="finish-selection"]': 'coverage'

  coverage:
    header: translate 'span.content', 'tutorial.coverage.header'
    content: translate 'div', 'tutorial.coverage.content'
    attachment: ['center', 'top', '.subject .marking-surface', 420 / 640, 240 / 360]
    arrow: 'up'
    next: 'sendOff'

  sendOff:
    header: translate 'span.content', 'tutorial.sendOff.header'
    content: translate 'div', 'tutorial.sendOff.content'
