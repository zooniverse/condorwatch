# http://zooniverse-demo.s3-website-us-east-1.amazonaws.com/condors/subjects/standard/5282aaaa3ae74095c100a382.jpg

module.exports =
  prompt:
    header: '<span>Welcome to Condor Watch</span>'
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
    header: '''
      <span>Welcome to Condor Watch</span>
    '''
    content: '''
      Help us better understand the social dynamic of condors by identifying them in photos across California, U.S.
    '''
    next: 'introduceTask'

  introduceTask:
    header: '''
      <span>Welcome to Condor Watch</span>
    '''
    content: '''
      We are primarily asking you to identify individual condors by describing as best you can the tag that each condor has pegged to its wing. There may also be other birds or animals to classify, see the guide for more details. Let's run through an example to get you started.
    '''
    next: 'markCondor'

  markCondor:
    header: '''
      <span>Identify a condor</span>
    '''
    content: '''
      Marking a condor is as simple as clicking on a condor in the image. Let's mark condor #32 that is foremost in this image.
    '''
    instruction: '''
      Click on the condor in this image to proceed.
    '''
    next: 'denoteCondor' # TODO

  denoteCondor:
    header: '''
      <span>Identify a condor</span>
    '''
    content: '''
      You will see a list of different animals on the right. We ask you mark when you spot each of these. In this case, we are marking a condor.
    '''
    instruction: '''
      Click "Condor", then "Next" to proceed.
    '''
    next: 'tagDetails' # TODO

  tagDetails:
    header: '''
      <span>Tag Details</span>
    '''
    content: '''
      This area lists the different pieces of information we are asking you to observe about each condor. Pleaes fill it out as best you can. For more details on the different pieces of information present, please refer to the field guide.
    '''
    next: 'markZoom'

  markZoom:
    header: '''
      <span>Toggle zoom</span>
    '''
    content: '''
      You'll notice there is a zoomed-in view where you placed the mark. This allows you to spot more details about the tag. You can toggle this zoom by click the magnifying glass here.
    '''
    next: 'markDelete'

  markDelete:
    header: '''
      <span>Delete a mark</span>
    '''
    content: '''
      You can also delete a mark entirely by clicking this &times;.
    '''
    block: 'button[name="delete-mark"]'
    next: 'completeMark'

  completeMark:
    header: '''
      <span>Complete this mark</span>
    '''
    content: '''
      To complete a mark, select how far the animal is from the carcass or scale, then click "Done".
    '''
    instruction: '''
      Click "Done"
    '''
    next: 'coverage' # TODO

  coverage:
    header: '''
      <span>What to mark</span>
    '''
    content: '''
      Please mark every condor and animal you can, even those condors that you can't discern all their tag details. Even partial information is potentially useful to us!
    '''
    next: 'sendOff'

  sendOff:
    header: '''
      <span>That's it!</span>
    '''
    content: '''
      Feel free to join the discussion on Talk, and be sure to sign up or log in to track your favorite condor images! Happy spotting!
    '''
