module.exports =
  siteNavigation:
    projectName: 'Condor Watch'
    home: 'Home'
    classify: 'Classify'
    fieldGuide: 'Field guide'
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
      start: 'Get started'
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
      image: './images/animals/condor.jpg'
    turkeyVulture:
      label: 'Turkey vulture'
      image: './images/animals/turkey-vulture.jpg'
    goldenEagle:
      label: 'Golden eagle'
      image: './images/animals/golden-eagle.jpg'
    raven:
      label: 'Raven'
      image: './images/animals/raven.jpg'
    coyote:
      label: 'Coyote'
      image: './images/animals/coyote.jpg'
    carcassOrScale:
      label: 'Carcass/&#8203;scale'
      image: '//placehold.it/100.png&text=Carcass/scale' # TODO

  classifier:
    favorite: 'Favorite'
    discuss: 'Dicuss'
    fieldGuide: 'Field guide'
    startTutorial: 'Start tutorial'
    share: 'Share'
    deleteMark: 'Delete'
    makeSelection: 'Click on each animal in the image and describe it using the options that appear.'
    finishSubject: 'Finished with this image'
    whatKind: 'What kind of animal is this?'
    back: 'Back'
    confirmAnimal: 'Next'
    enterLabel: 'Describe what you can see of the condor\'s tag.'
    tagLabel: 'Tag number'
    color: 'Tag color'
    colors:
      clear: 'Un-set color'
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
    adult: 'Adult'
    proximity: 'How close is this animal to the carcass or scale?'
    proximities:
      withinReach: 'Within reach'
      withinTwo: 'Within two body lengths'
      outsideTwo: 'Farther than two body lengths'
    finishSelection: 'Done'

  classificationSummary:
    condorsHeading: '$count confirmed condors'
    noCondors: 'No condors marked'
    tagPrefix: 'No.'
    bioLink: 'Bio'
    othersHeading: 'Other animals'
    noOthers: 'No other animals marked'
    readyForNext: 'Image classified! Ready for the next one?'
    ready: 'Ready'

  condorBio:
    tagPrefix: 'No.'
    sex: 'Sex'
    hatched: 'Hatched'
    rearedBy: 'Reared by'
    released: 'Released'
    died: 'Died'
    father: 'Father'
    mother: 'Mother'
    poisoned: 'Poisoning frequency'
    firstBred: 'First bred'
    chicks: 'Chicks contributed'
    mateInYear: 'Mate in $year'
    years: 'years'
    stillAlive: 'Still kickin\''

  fieldGuide:
    title: 'Field guide'
    back: 'Back to classification'
    summary: 'What to look for when classifying'

    condor: '''
      <p>California condors are the largest flying land birds in North America. Being almost 4 feet head-to-tail with a wing span of 9.5 feet and weighing 22 lbs on average, they will always be the largest birds in a Condor Watch photograph. But when perspective makes size hard to discern, we must rely on other field marks. Overall, they are a brownish-black feathered vulture with conspicuous white patches on their underwings. They have a feathered “ruff” about their neck which can be pulled up towards their head on cold days. Their heads are bare except for a black “mustache” below the eyes, and their head color is largely what you will use to tell adults and juvenile apart (see section below). Condors also have un-feathered crops, a pouch above the stomach where food can be stored for later digestion. When full, these crops can be obvious in the photographs, especially in adults when the crop is bright pink in color.</p>
      <p>Perhaps the biggest clue that you are looking at a condor is the presence of a numbered tag on their wing, called a patagial tag, which helps field biologists identify individuals.</p>
      <div class="centered">
        <h4>Adult or juvenile?</h4>
        <img src="//placehold.it/100.png&amp;text=Juvenile" class="framed" />
        <img src="//placehold.it/100.png&amp;text=Adult" class="framed" />
      </div>
      <p>Juvenile condors are the same size as adult condors, but they differ in head color and, more subtly, in plumage. Juveniles have dark grey heads and necks with black downy feathers. The white patches on the undersides of their wings are generally blotchier than the white triangular patches found beneath the wings of adults. As they grow into adults, a process that takes 5-6 years, skin on their head, neck, and crop turns pink to orange, and the white underwing patch becomes more defined. Condor eye color also changes from brown to red as they age into adulthood. For the purposes of this project, only condors with completely pink-orange heads will be considered adults. Fun fact: adult condors can reportedly change their skin color from pale grey blue, to bright red, to deep yellows to communicate with other condors.</p>
    '''

    turkeyVulture: '''
      <p>Turkey vultures are the most common vulture in North America. They have brownish-black feathers and bare heads, similar the California condor but are much smaller (~ 2 feet head-to-tail, 4 lbs). Since turkey vultures use their sense of smell to find prey, their nostrils (a.k.a. nares) are highly developed. During their first year after hatching, turkey vultures have black heads and bills. In about 2 years they have achieved full adult plumage, with bright red heads and ivory bills.</p>
      <div class="centered">
        <h4>How to tell the difference</h4>
        <img src="//placehold.it/200.png&amp;text=Comparison" class="framed" />
      </div>
      <p>As mentioned in the previous section, turkey vultures are less than half the size of California condors. But how can you tell the difference if only one species is in the photograph? Well, one way is to look for a patagial tag, a large numbered tag on the wing. Only condors should have these tags. Another clue is the wing plumage. Condors, especially adults, have large white patches on the underside of their wings. If positioned correctly you may be able to see these. Turkey vultures have a silvery trailing edge to the underside of their wings, but have no white feathers at all.</p>
    '''

    goldenEagle: '''
      <p>The golden eagle is larger than a turkey vulture, but smaller than a condor. At 10 lbs and 2.5 feet head-to-tail with a wingspan of 6.5 feet, it is about 2/3 the size. These predatory birds are feathered from beak to feet, their leg feathers giving the effect of billowing pants. They are golden brown overall and may have some white markings on the underwings and tail depending on age. Despite their being smaller than condors, the golden eagle tends to be dominant at a carcass, perhaps since it has powerful talons which the other scavengers lack.</p>
    '''

    raven: '''
      <p>Common Ravens are often present at condor feeding events. With a wingspan of just over 4 feet and a weight of 2.6 lbs on average, these birds are smaller than turkey vultures. Ravens are feathered black, with similarly black beak, eyes, and legs. In the right light, their feathers shine with iridescence.</p>
      <p>While ravens are omnivores, they are accomplished scavengers and are often present in condor watch photographs. This species is highly intelligent and have been observed to play “tricks” on larger scavengers while they eat, such as tugging condor tail feathers to distract them from their meal.</p>
    '''

    coyote: '''
      <p>If you are lucky you may catch a mammal on the condor cam. When you do, it will most likely be the coyote, a member of the Canidae family which is both predator and scavenger. Interestingly, this species, once deceased, becomes a food source for the California condor!</p>
    '''

    carcassOrScale: '''
      <p>For this project we also ask that you locate the carcass and the scale within photographs. This will help us understand how far each bird is from the carcass, and ultimately decode the dominance hierarchy within condor flocks as well as further our understanding of condor feeding behavior. Carcasses are generally dairy calves colored white, black, and brown. Occasionally condors will be offered a wild boar or rabbit. The scale is used to collect data on individual condor weights, an indicator of overall health.</p>
    '''

    credit: '''
      <p>Text by Zeka Kuspa</p>

      <p>Sources:</p>
      <ul>
        <li>Sibley, David A., The Sibley Guide to Birds of North America, 2000. Chanticleer Press, New York.</li>
        <li>Ventana Wildlife Society website: http://ventanaws.org/species_condors_history/</li>
        <li>Pinnacles National Park website: http://www.nps.gov/pinn/naturescience/condor-viewing-tips.htm</li>
      </ul>
    '''

  science:
    title: 'Science'
    summary: 'This page will explain the science end of the project.' # TODO
    content: '''
      <h3>Overview</h3>
      <p>Condors are regularly released in several regions in California and are also frequently recaptured for medical care, including chelation for lead poisoning, which results from ingesting bullet fragments in carcasses from animals hunted with lead ammunition. Our project consists of hundreds of thousands of photographs taken by remotely triggered cameras at proffered feeding stations. These feeding stations are sites, located across the range of the condor in California, where uncontaminated animal carcasses are placed out for the birds to feed on,  in part to keep the birds acclimated so they can be trapped regularly for health monitoring. . Photos from these feeding stations are labor-intensive to process, and yet they provide some of the best data on the history of each bird’s behaviors and social interactions and also the best real-time information on the health of individual birds, since not all birds carry radio or GPS transmitters. Currently, managers glean only immediate health data from these photos, although the photographs contain many different kinds of information that could be used to better understand the social interactions, individual personalities of condors, and the ecology of this highly endangered species.</p>
      <h3>Data use and accessibility</h3>
      <p>Condors roost and forage in groups and group membership appears to be at least somewhat fluid on a daily basis, although mated pairs often forage together. Individuals foraging together may have a similar risk of being lead poisoned  if they jointly ingest contaminated carrion, especially if lead ammunition fragments are spread throughout carcasses. Alternatively, dominant individuals may exhibit the highest lead levels because they have first access to the bullet entry site, where the tough hide is pierced. For birds that have not reached full adult status, dominance is generally determined by age; among adults, dominance appears to be influenced by age as well as personality traits. If dominance increases lead ingestion, lead levels should increase with age up until adult status is attained. However, exploration and thus exposure to non-proffered food items may increase with age, which would also result in a pattern of increasing lead levels with age.</p>
      <p>Our project goal is to gain a better understanding of whether observed foraging associations and other patterns of feeding station use predicted blood lead levels in California condors.  We plan to assess the likelihood that associations at feeding stations predict foraging associations at wild locations, as well as evaluate the strength of social structuring and the temporal scale of associations in feeding aggregations. We will then test for whether age, sex, and rearing method predicted associations and the likelihood of feeding at feeding stations. Finally, we will evaluate whether age and associations between individuals predicted elevated blood lead levels.</p>
      <p>From the data collected by Condor Watch, we plan to generate a social network map of the condor population free-flying within California.  As the project gathers more data, social network maps will evolve. Detailed data on interactions between individuals in wild populations are rare. Therefore, we anticipate that these data will be of considerable interest to multiple groups of scientists--those interested in: patterns of social interactions; the effects of learning on reintroduction efforts; and ecotoxicological problems in wild species.  Data will be publically available through appendices in one or more scientific journal publications. We will also create a registry in the Knowledge Network for Biocomplexity (KNB) database. KNB was created with input from National Center for Ecology and Statistics and is a go-to point for ecologists looking for appropriate datasets for testing novel analyses.</p>
      <h3>Preliminary findings on why this project is important</h3>
      <p>We completed a preliminary analysis of data collected at proffered feeding stations equipped with still and video cameras in Pinnacles National Park in California, USA. Condor associations were relatively fluid through time, with the probability of any two currently-associated individuals being associated in the future remaining constant for about a month then slowly declining towards rates expected from random or null association behavior. Association rates among pairs of condors at feeding stations did not predict the probability that both exhibited elevated lead levels. However, we plan to test this prediction with the larger data set generated through Condor Watch to determine if our lack of an association was due to our small preliminary sample size.</p>
      <p>The strength of an individual’s social connections (i.e., its network centrality) was negatively related to age. However, more socially connected individuals had a greater probability of elevated blood lead after accounting for age and site effects. Thus, we feel that data generated from Condor Watch will be valuable to help determine factors that can predict a condor’s lead poisoning risk, as well as understand condor social network behavior more generally.</p>
    '''

  about:
    title: 'About the project'
    summary: '''
      California condors are the largest North American terrestrial bird and one of the world’s rarest species. Condor populations collapsed to only 22 individuals in the 1980s before being captured, bred in captivity, and released again to reform wild populations. We are working to understand the threats to this species, and how to plan for its continued recovery from the brink of extinction.
    '''
    content: '''
      <p>California condors (<i>Gymnogyps californianus</i>) are one of the world’s most endangered bird species with a global population approaching only a few dozen birds in the early 1980s. Despite successful captive breeding and release efforts in recent years, condors remain heavily managed because they are frequently poisoned by lead from bullet fragments ingested in scavenged carcasses. Condor release sites offer uncontaminated carcasses to birds as a way to lure them back for medical care and regular management activities. Release sites are equipped with automatically triggered cameras that have captured photographs of condors in the past 10 years. The Condor Watch Project will analyze these photographs in order to understand how the personalities and social status of individual birds may predispose them to lead poisoning and to eventually gather critical real-time information on the health and status of these highly vulnerable birds.</p>
    '''

  scienceTeam:
    bakker:
      name: 'Vickie Bakker'
      image: '//placehold.it/100.png'
      description: '''
        Vickie is an assistant research professor in the Department of Ecology at Montana State University. Vickie’s focus is adapting the academic tools of quantitative conservation ecology to solve the real world problems of conservation practitioners managing rare and endangered species. She has developed population models and evaluated management options for species ranging from island fox to northern woodland caribou to black-footed albatross. Vickie brings expertise in large-scale data analysis and quantitative population biology to Condor Watch. She will harness the power of a hefty existing database on the life and times of each condor to help understand what the social lives of condors reveal about their risk of contaminant exposure, their breeding success and survival, and ultimately their long-term population dynamics.
      '''
    copeland:
      name: 'Holly Copeland'
      image: '//placehold.it/100.png'
      description: '''
        Holly is a Spatial Ecologist with The Nature Conservancy in Lander, Wyoming. Holly’s research applies GIS and modeling tools to Western conservation issues, especially forecasting future impacts of energy and residential development, climate change, and invasive species on ecosystems and wildlife, with an emphasis most recently on sage-grouse and mule deer. Holly’s expertise in spatial analysis will allow the data gathered by Condor Watch to be used to understand how condor movement behavior is affected by their social networks and ultimately how this information can be applied to bolster the long-term conservation of condors.
      '''
    doak:
      name: 'Dan Doak'
      image: '//placehold.it/100.png'
      description: '''
        Dan is a Professor in the Environmental Studies Program at the University of Colorado, Boulder. Dan's research interests are broad and range from the ecology and management of rare species and habitats and biodiversity protection and management to population and community ecology and the effects of climate change on ecological systems. He has contributed to conservation analyses for many rare species including grizzly bears, cheetahs, sea otters, and condors. Dan brings expertise in quantitative population biology to the Condor Watch project, and he will help oversee data analyses to ensure the project yields rigorous scientific output and contributes to meaningful condor conservation.
      '''
    finkelstein:
      name: 'Myra Finkelstein'
      image: '//placehold.it/100.png'
      description: '''
        Myra is an Assistant Adjunct Professor in the Microbiology and Environmental Toxicology Department at the University of California Santa Cruz and her research focuses on human impacts to wildlife with an emphasis on contaminant-induced effects. Myra has been studying the sources and effects of lead exposure to the endangered California Condor for over five years and has published results which state that California condors are chronically exposed to harmful levels of lead, lead-based ammunition is the principal source of lead poisoning to condors, and that lead poisoning is preventing condor recovery. Myra is the Condor Watch project lead and brings expertise in toxicology to the team.  In addition to overall oversight, she will guide analyses involving linkages between social structure and the risk of exposure to lead and marine contaminants.
      '''
    rose:
      name: 'Alexandra Rose'
      image: '//placehold.it/100.png'
      description: '''
        Alexandra (Alex) is the Citizen Scientist Coordinator at the University of Colorado Museum of Natural History and Science Discovery. Alex’s expertise is avian ecology and although she’s primarily a bird biologist, Alex has also worked with a variety of species including white-tailed deer, small mammals, and even polar bears. Besides working with the Condor Watch team, she lead a field-based citizen science project devoted to the conservation of native bee and wasp diversity in Colorado called The Bees’ Needs. Alex bring expertise in citizen science to Condor Watch and will oversee science communications and generally making sure the project is both fun and productive for the Condor Watch science team and the Condor Watchers.
      '''
    shizuka:
      name: 'Daizaburo Shizuka'
      image: '//placehold.it/100.png'
      description: '''
        Daizaburo (Dai) is a Research Assistant Professor in the School of Biological Sciences at University of Nebraska-Lincoln. Dai’s research focuses on social behavior in birds. His work includes the spatial and temporal dynamics of social networks of animals in various contexts, including dominance hierarchies and flock membership. Dai brings expertise in social network analysis to Condor Watch, and he will help construct the social networks of condors based on which birds feed together at carcasses. Mapping these “friendships” will allow the project to assess whether patterns of association contribute to the spread of lead poisoning and other risk factors in the population.
      '''

  profile:
    title: 'Your profile'

  education:
    title: 'For educators'
    summary: 'This is where educational info will go.'
    content: '''
      <p>Includes links to other resources, links to ZooTeach, etc.</p>
    '''

  dateFormat: '$month $day, $year'
  months:
    jan: 'January', feb: 'February', mar: 'March', apr: 'April'
    may: 'May', jun: 'June', jul: 'July', aug: 'August'
    sep: 'September', oct: 'October', nov: 'November', dec: 'December'
