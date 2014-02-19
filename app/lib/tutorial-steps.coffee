translate = require 't7e'

# http://zooniverse-demo.s3-website-us-east-1.amazonaws.com/condors/subjects/standard/5282aaaa3ae74095c100a382.jpg

module.exports =
  prompt:
    header: translate 'span.content', 'tutorial.prompt.header'
    content: translate 'div', 'tutorial.prompt.content'
    nextLabel: translate 'span', 'tutorial.prompt.nextLabel'

    onLoad: ->
      rejectButton = @createElement 'button.zootorial-nah', @footer
      @footer.appendChild rejectButton.previousElementSibling # Reorder
      rejectButton.innerHTML = translate 'span', 'tutorial.prompt.rejectLabel'
      rejectButton.onclick = =>
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
    next:
      'tool-initial-release': 'denoteCondor'

  denoteCondor:
    header: translate 'span.content', 'tutorial.denoteCondor.header'
    content: translate 'div', 'tutorial.denoteCondor.content'
    instruction: translate 'div', 'tutorial.denoteCondor.instruction'
    actionable: 'button[name="animal"][value="condor"], button[name="confirm-animal"]'
    next:
      'click button[name="confirm-animal"]': 'tagDetails'

  tagDetails:
    header: translate 'span.content', 'tutorial.tagDetails.header'
    content: translate 'div', 'tutorial.tagDetails.content'
    block: 'button[name="finish-selection"]'
    next: 'markZoom'

  markZoom:
    header: translate 'span.content', 'tutorial.markZoom.header'
    content: translate 'div', 'tutorial.markZoom.content'
    block: 'button[name="finish-selection"]'
    next: 'markDelete'

  markDelete:
    header: translate 'span.content', 'tutorial.markDelete.header'
    content: translate 'div', 'tutorial.markDelete.content'
    block: 'button[name="delete-mark"], button[name="finish-selection"]'
    next: 'completeMark'

  completeMark:
    header: translate 'span.content', 'tutorial.completeMark.header'
    content: translate 'div', 'tutorial.completeMark.content'
    instruction: translate 'div', 'tutorial.completeMark.instruction'
    actionable: 'button[name="proximity"], button[name="finish-selection"]'
    next:
      'click button[name="finish-selection"]': 'coverage'

  coverage:
    header: translate 'span.content', 'tutorial.coverage.header'
    content: translate 'div', 'tutorial.coverage.content'
    next: 'sendOff'

  sendOff:
    header: translate 'span.content', 'tutorial.sendOff.header'
    content: translate 'div', 'tutorial.sendOff.content'
