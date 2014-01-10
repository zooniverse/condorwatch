module.exports =
  siteNavigation:
    projectName: 'Condor Watch'
    home: 'Home'
    classify: 'Classify'
    science: 'Science'
    about: 'About'
    profile: 'Profile'
    education: 'Education'
    talk: 'Discuss'
    blog: 'Blog'

  home:
    header:
      title: 'The California condors need your help!'
      content: '''
        The California condor is a critically endangered species and the population is suffering from the affects of lead poisoning.
        By tracking the location and social behavior of the creatures we can better detect early warning signs of the illness.
      '''
      start: 'Get started!'
    whatDo:
      title: 'What can you do?'
      content: '''
        We need you to look at some photos of condors taken by our motion-activated cameras.
        By identifying the tag number of each condor and their behavior around the feeding carcass,
        we can judge if the bird's eating or social problems can reveal lead poisoning.
      '''

  animals:
    condor:
      label: 'Condor'
      image: '//placehold.it/100.png&text=Condor'
    turkeyVulture:
      label: 'Turkey vulture'
      image: '//placehold.it/100.png&text=Turkey vulture'
    raven:
      label: 'Raven'
      image: '//placehold.it/100.png&text=Raven'
    coyote:
      label: 'Coyote'
      image: '//placehold.it/100.png&text=Coyote'

  classifier:
    title: 'Classify'
    markAnimals: 'Mark each animal in this photo by $action.'
    clicking: 'clicking your mouse'
    tapping: 'tapping it'
    finished: 'Finished'

    whatKind: 'What kind of animal is this?'

    enterLabel: 'Describe the condor\'s tag, if you can read it.'
    tagLabel: 'Tag no.'
    color: 'Tag color'
    colors:
      black: 'Black'
      white: 'White'
      red: 'Red'
      orange: 'Orange'
      yellow: 'Yellow'
      green: 'Green'
      blue: 'Blue'
      purple: 'Purple'
    dots: 'Dots'
    none: '(None)'
    underlined: 'Underlined'

    estimateProximity: 'Estimate how close this condor is to the carcass or scale, relative to the other condors.'
    proximityNear: 'Near'
    proximityFar: 'Far'

    isFeeding: 'Is this animal currently feeding on a carcass?'
    yes: 'Yes'
    no: 'No'

    cancel: 'Cancel'
    next: 'Next'
    done: 'Done'
    delete: 'Delete'

  classificationSummary:
    title: 'Summary'
    noTags: '(No tags visible)'
    relativeAge: 'Relative age'
    born: 'Born'
    died: 'Died'
    share: 'Share the story <br />of <small>No.</small> $tag'
    readyForNext: 'Image classified! Ready for the next one?'
    ready: 'Ready!'

  science:
    title: 'Science!'
    summary: 'This page will explain the science end of the project.'
    content: '''
      <p>Tell us about condors. Tell us why they're almost extinct, and how we're helping bring them back.</p>
      <p>Tell us about lead poisoning.</p>
      <p>Etc.</p>
    '''

    figures:
      something:
        image: '//placehold.it/640x480.png'
        description: 'This is a feature of condors'

  about:
    title: 'About the project'
    summary: 'Technical details of the project'
    content: '''
      <p>Who's doing the science? Who's doing the development? What groups are involved? And links to all these things.</p>
    '''

  profile:
    title: 'Your profile'

  education:
    title: 'For educators'
    summary: 'This is where educational info will go.'
    content: '''
      <p>Includes links to other resources, links to ZooTeach, etc.</p>
    '''
