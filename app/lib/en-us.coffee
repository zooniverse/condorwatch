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
        The California condor is a critically endangered species and the population is suffering from the effects of lead poisoning.
        By tracking the location and social behavior of the animals we can better detect early warning signs of the illness.
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
    goldenEagle:
      label: 'Golden eagle'
      image: '//placehold.it/100.png&text=Golden eagle'
    carcassOrScale:
      label: 'Carcass/scale'
      image: '//placehold.it/100.png&text=Carcass/scale'


  classifier:
    title: 'Classify'
    makeSelection: 'Click on each animal in the image and describe it using the options that appear.'
    finishSubject: 'Finished with this image'
    whatKind: 'What kind of animal is this?'
    confirmAnimal: 'Next'
    enterLabel: 'Describe what you can see of the condor\'s tag.'
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
    noDots: 'No dots'
    someDots: '$n dot(s)'
    underlined: 'Underlined'
    juvenile: 'Juvenile'
    proximity: 'How close is this animal to the carcass or scale?'
    proximities:
      withinReach: 'Within reach'
      withinTwo: 'Within two body lengths'
      outsideTwo: 'Farther than two body lengths'
    finishSelection: 'Done'

  classificationSummary:
    title: 'Summary'
    noTags: '(No tags visible)'
    relativeAge: 'Relative age'
    details: 'See details'
    noDetails: 'Couldn\'t find details'
    share: 'Share the story <br />of <small>No.</small> $tag'
    readyForNext: 'Image classified! Ready for the next one?'
    ready: 'Ready!'

  condorBio:
    sex: 'Sex'
    hatched: 'Hatched'
    rearedBy: 'Reared by'
    released: 'Released'
    died: 'Died'
    father: 'Father'
    mother: 'Mother'
    poisoned: 'Frequency of poisoning'
    firstBred: 'First bred'
    chicks: 'Chicks contributed'
    mateInYear: 'Mate in $year'

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
