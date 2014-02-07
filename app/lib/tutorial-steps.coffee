module.exports =
  prompt:
    content: 'This is a tutorial! You in?'
    nextLabel: 'Let\'s go'

    onLoad: ->
      rejectButton = @createElement 'button.zootorial-nah', @footer
      @footer.appendChild rejectButton.previousElementSibling # Reorder
      rejectButton.innerHTML = 'No thanks'
      rejectButton.onclick = =>
        @triggerEvent 'reject'
        @end()

    next: 'welcome'

  welcome:
    content: 'Welcome to Condor Watch'
