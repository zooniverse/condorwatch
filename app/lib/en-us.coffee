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
    carcass:
      label: 'Carcass'
      image: '//placehold.it/512.png&text=TODO'
    other:
      label: 'Something else'
      image: '//placehold.it/512.png&text=TODO'
    carcassOrScale:
      label: 'Carcass/&#8203;scale'
      image: './images/animals/carcass-or-scale.jpg'

  classifier:
    favorite: 'Favorite'
    discuss: 'Discuss'
    fieldGuide: 'Field guide'
    startTutorial: 'Start tutorial'
    share: 'Share'
    deleteMark: 'Delete'
    makeSelection: 'Click on every animal you can see in this image and describe it in as much detail as you can using the options that appear.'
    finishSubject: 'All animals marked'
    incomplete: 'Incomplete markings! Check for solid red dots.'
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
    carcassHint: 'Remember you only need to mark near the center of each carcass, even if it\'s in several pieces.'
    talkReminder: 'Don\'t forget to tell us what you see in Talk after you\'re finished classifying!'
    finishSelection: 'Done'
    noMoreSubjects: 'Looks like we\'ve run out of subjects!<br />Please check back later.' # TODO: Point to other projects.
    required: '(Required)'

  tutorial:
    demoLabel: 'Show me'
    nextLabel: 'Next'
    doneLabel: 'Done'

    prompt:
      header: 'Welcome to Condor Watch'
      content: 'We\'ve put together a short tutorial to help get you started. Would you like to step through it now?'
      nextLabel: 'Yes'
      rejectLabel: 'No'

    welcome:
      header: 'Welcome to Condor Watch'
      content: '''
        Help us better understand the social dynamic of condors by identifying them in photos across California, U.S.
      '''

    introduceTask:
      header: 'Welcome to Condor Watch'
      content: '''
        We would like you to identify all animals that you can see in each photo. For all condors, we would like you to describe as best you can the tag that each condor has pegged to its wing. In some cases, the wing tag may not be visible, but we would still like you to mark the condor so we have a count of condors at the feeding site. Let’s run through an example to get you started.
      '''

    markCondor:
      header: 'Identify a condor'
      content: '''
        Marking a condor is as simple as clicking on a condor in the image. Let's mark condor #32 that is foremost in this image.
      '''
      instruction: '''
        Click on condor #32 in this image to proceed.
      '''

    denoteCondor:
      header: 'Identify a condor'
      content: '''
        You will see a list of different animals on the right. You'll place a mark where you spot each of these. In this case, we are marking a condor.
      '''
      instruction: '''
        Click "Condor", then "Next" to proceed.
      '''

    tagDetails:
      header: 'Tag Details'
      content: '''
        This area lists the different pieces of information we are asking you to observe about each condor. Please fill it out as best you can. For more details on the kinds of information we're asking you to collect, please refer to the Field Guide link (above).
      '''

    markZoom:
      header: 'Toggle zoom'
      content: '''
        You'll notice there is a zoomed-in view where you placed the mark. This allows you to spot more details about the tag. You can toggle this zoom by clicking the magnifying glass here.
      '''

    markDelete:
      header: 'Delete a mark'
      content: '''
        You can also delete a mark entirely by clicking this &times;.
      '''
      block: 'button[name="delete-mark"]'

    completeMark:
      header: 'Complete this mark'
      content: '''
        To complete a mark, select how far the animal is from the carcass or scale, then click "Done".
      '''
      instruction: '''
        Click "Within reach", then click "Done"
      '''

    coverage:
      header: 'What to mark'
      content: '''
        Please mark every condor and animal that you see, even if you can't read all the tag details. Even partial information is potentially useful to us!
      '''

    sendOff:
      header: 'That\'s it!'
      content: '''
        Feel free to join the discussion on Talk, and be sure to sign up or log in to track your favorite condor images! Happy spotting!
      '''

  classificationSummary:
    condorsHeading: '$count condors'
    condorsExplanation: 'Given our existing data and the information you provided, here is our best guess of the condors in this image.'
    noCondors: 'No condors marked'
    tagPrefix: 'Tag'
    sureness: 'sure this matches condor'
    bioLink: 'Bio'
    noBioLink: 'No bio'
    othersHeading: 'Other animals'
    noOthers: 'No other animals marked'
    wantToTalk: 'Do you want to $verb this image?'
    verbs:
      talk: 'talk about'
      discuss: 'discuss'
    yes: 'Yes'
    no: 'No'
    nextImage: 'Next image'

  condorBio:
    tagPrefix: 'No.'
    tagged: 'Tagged as'
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

  cantFindBio:
    title: 'Unidentifed condor'
    content: '''
      <p>Sometimes we can't identify a specific bird using the information provided in this interface.</p>
      <p>Don't worry! <i class="fa fa-smile-o"></i></p>
      <p>It doesn't necessarily mean you did something incorrectly, it just means we need to take additional data into account before using the your contribution. No problem!</p>
      <hr />
      <p>If you need a hand reading wing tags anyway, check the <a href="#/field-guide/wing-tags">field guide to reading wing tags</a>.</p>
    '''

  fieldGuide:
    title: 'Field guide'
    back: 'Back to classification'
    summary: 'What to look for when classifying'

    condor: '''
      <p>California condors are the largest flying land birds in North America. Being almost 4 feet head-to-tail with a wing span of 9.5 feet and weighing 22 lbs on average, they will always be the largest birds in a Condor Watch photograph. But when perspective makes size hard to discern, we must rely on other field marks. Overall, they are a brownish-black feathered vulture with conspicuous white patches on their underwings. They have a feathered “ruff” about their neck which can be pulled up towards their head on cold days. Their heads are bare except for a black “mustache” below the eyes, and their head color is largely what you will use to tell adults and juvenile apart (see section below). Condors also have un-feathered crops, a pouch above the stomach where food can be stored for later digestion. When full, these crops can be obvious in the photographs, especially in adults when the crop is bright pink in color.</p>
      <p>Perhaps the biggest clue that you are looking at a condor is the presence of a numbered tag on their wing, called a patagial tag, which helps field biologists identify individuals.</p>
      <div class="centered">
        <h4>Adult or juvenile?</h4>
        <img src="./images/adult.jpg" class="framed" width="100" height="100" />
        <img src="./images/juvenile.jpg" class="framed" width="100" height="100" />
      </div>
      <p>Juvenile condors are the same size as adult condors, but they differ in head color and, more subtly, in plumage. Juveniles have dark grey heads and necks with black downy feathers. The white patches on the undersides of their wings are generally blotchier than the white triangular patches found beneath the wings of adults. As they grow into adults, a process that takes 5-6 years, skin on their head, neck, and crop turns pink to orange, and the white underwing patch becomes more defined. Condor eye color also changes from brown to red as they age into adulthood. For the purposes of this project, only condors with completely pink-orange heads will be considered adults. Fun fact: adult condors can reportedly change their skin color from pale grey blue, to bright red, to deep yellows to communicate with other condors.</p>
    '''

    turkeyVulture: '''
      <p>Turkey vultures are the most common vulture in North America. They have brownish-black feathers and bare heads, similar the California condor but are much smaller (~ 2 feet head-to-tail, 4 lbs). Since turkey vultures use their sense of smell to find prey, their nostrils (a.k.a. nares) are highly developed. During their first year after hatching, turkey vultures have black heads and bills. In about 2 years they have achieved full adult plumage, with bright red heads and ivory bills.</p>
      <div class="centered">
        <h4>How to tell the difference</h4>
        <figure>
          <img src="./images/comparison.jpg" class="framed" width="200" height="200" />
          <figcaption>From left to right: a condor, a raven, and a turkey vulture</figcaption>
        </firgure>
      </div>
      <p>As mentioned in the previous section, turkey vultures are less than half the size of California condors. But how can you tell the difference if only one species is in the photograph? Well, one way is to look for a patagial tag, a large numbered tag on the wing. Only condors should have these tags. Another clue is the head size. Condors have much larger heads than turkey vultures.</p>
    '''

    goldenEagle: '''
      <p>The golden eagle is larger than a turkey vulture, but smaller than a condor. At 10 lbs and 2.5 feet head-to-tail with a wingspan of 6.5 feet, it is about 2/3 the size. These predatory birds are feathered from beak to feet, their leg feathers giving the effect of billowing pants. They are golden brown overall and may have some white markings on the underwings and tail depending on age. Despite their being smaller than condors, the golden eagle tends to be dominant at a carcass, perhaps since it has powerful talons which the other scavengers lack.</p>
    '''

    raven: '''
      <p>Common Ravens are often present at carcasses. With a wingspan of just over 4 feet and a weight of 2.6 lbs on average, these birds are smaller than turkey vultures. Ravens are feathered black, with similarly black beak, eyes, and legs. In the right light, their feathers shine with iridescence.</p>
      <p>While ravens are omnivores, they are accomplished scavengers and are often present in condor watch photographs. This species is highly intelligent and have been observed to play “tricks” on larger scavengers while they eat, such as tugging condor tail feathers to distract them from their meal.</p>
    '''

    coyote: '''
      <p>If you are lucky you may catch a mammal on the condor cam. When you do, it will most likely be the coyote, a member of the Canidae family which is both predator and scavenger. Interestingly, this species, once deceased, becomes a food source for the California condor!</p>
    '''

    # TODO: What other animals will we see?
    other: '''
      <p>Anything else you might see: some hungry mountain lions and bears out for a stroll, perhaps?</p>
    '''

    carcassOrScale: '''
      <p>For this project we also ask that you locate the carcass and the scale within photographs. This will help us understand how far each bird is from the carcass, and ultimately decode the dominance hierarchy within condor flocks as well as further our understanding of condor feeding behavior. Carcasses are generally dairy calves colored white, black, and brown. Occasionally condors will be offered a wild boar or rabbit. The scale is used to collect data on individual condor weights, an indicator of overall health.</p>
    '''

    tags: '''
      <h3>A field guide to reading wing tags</h3>
      <p>Wing tags, or patagial tags, are vinyl tags placed on wings to allow biologists to visually identify individual condors. We hope they will help you to do the same! Each tag has a (mostly) unique combination of color and number, and some have underline or dots underneath the number. Here are some examples:</p>
      <p><img src="./images/40-three-dots.jpg" /></p>
      <p>In the above photo, you can see a black tag with 3 dots below. You can indicate the number of dots by clicking 3 dots in the tag information window.</p>
      <p><img src="./images/25-underlined.jpg" /></p>
      <p>Here, you can see three different tags: black tag 43 with an underline, black tag 25 with underline, and a blue tag 11. Each bird is wearing a radio transmitter on their wing tags. You can indicate that a tag has an underline by checking the box as indicated. In this case, we cannot determine the age because the field marks (e.g., head color) are not visible.</p>
      <p><img src="./images/84-juvenile.jpg" /></p>
      <p>Here, you can see three visible tags: a white tag 83, red tag 47, and black tag 84. Both Red 47 and Black 84 are wearing transmitters on their wing tags. Note that there is also a golden eagle and two ravens in the background. You can tell that the condor with black tag 84 is a juvenile because of its head color (black).</p>
      <h4>Cracking the condor code</h4>
      <p>Each condor has a unique 3 digit studbook number assigned at hatching. Over the course of the condor reintroduction effort, systems were developed at each release site managed by the US Fish and Wildlife Service, Pinnacles National Park, and Ventana Wildlife Society using numbers, colors, dots, and underlines to allow a condor’s studbook number to be read from afar. When you are lucky enough to have the right light and bird position to read a wing tag, you can crack the condor code to identify which individual condor you are looking at.</p>
      <p>Here’s the break down: The numbers on wing tags indicate the last two digits of the studbook number. If a condor only has one number on its tag, then the tens place digit is a zero (e.g. 401). Colors, dots, and underlines indicate the first digit. For example, at some release sites, a blue tag symbolizes that the condor’s studbook number is in the 300’s series. And at another site, three dots below the tag number also indicates a “3” in the hundreds place. So if you see a condor wearing a blue tag with the number “11,” that’s condor 311! How about a condor sporting a black wing tag with the number “51” above 3 dots? That’s 351! When you classify a condor tag, you will be able to learn more about that individual’s lineage and life history by clicking their studbook number on the summary screen. Over time, you may be able to crack the rest of the condor code and begin to recognize individuals by their tags just like we do in the field. Good luck!</p>
    '''

    ambiguousTags: '''
      <h3>What if only one digit of the tag is visible?</h3>

      <p>If you can only see one digit, but it looks like there are two there, there are a couple of options. The first is to report your best guess based on the parts of the number you can see. The second option is to just enter the digit you see and then put an "X" where the other digit would go. For example, in the images below, you could enter 9X (left) and 1X(right, yellow tag). However, volunteers who become familiar with the shapes of numbers on tags might make an educated guess and enter 94 for 14.</p>

      <div class="focused">
        <img src="./images/tag-examples/guessing-example-1.jpg" />
        <img src="./images/tag-examples/guessing-example-2.jpg" />
      </div>

      <p>In the two images below, it is essentially impossible to guess at the missing digit. In this case, enter 9X (left) or 1X (right).</p>

      <div class="focused">
        <img src="./images/tag-examples/guessing-example-3.jpg" />
        <img src="./images/tag-examples/guessing-example-4.jpg" />
      </div>

      <p>Note that in other cases, the first digit might be obscured, in which case enter X in the ten's place.</p>
    '''

    condorOrVulture: '''
      <h3>Condor or Turkey Vulture?</h3>

      <p>Here are some photos that show condors and turkey vultures together to help you see the differences (and similarities).</p>

      <img src="./images/condor-vulture-1.jpg" />
      <p>The three birds in the back are turkey vultures (two on the right and one on the left), the large (and tagged) bird in the foreground is an adult condor.</p>

      <img src="./images/condor-vulture-2.jpg" />
      <p>Here is the same group, different positions: Three turkey vultures in the back and the same adult condor feasting in the foreground.</p>

      <img src="./images/condor-vulture-3.jpg" />
      <p>Here is an adult condor in the foreground and turkey vultures in the back left corner.</p>

      <img src="./images/condor-vulture-4.jpg" />
      <p>Here is an adult and juvenile condor in the foreground and two turkey vultures in the back right corner (one's head is visible but for the other one you can only see the back).</p>

      <img src="./images/condor-vulture-5.jpg" />
      <p>Here is juvenile condor in the foreground, next to another condor on the right (can't tell if juvenile or adult) and two turkey vultures in the background. Note the heads are more pointy and smaller for the turkey vultures. As it is hard to confirm the dark blob by the scale is a bird (or animal of any kind for that matter), we would suggest not marking it.</p>

      <img src="./images/condor-vulture-6.jpg" />
      <p>And here is a turkey vulture only party! (no condors invited).</p>
    '''

    markingTheCarcass: '''
      <h3>How to mark the carcass</h3>
      <p>We know that in many photos there is not one easily recognizable carcass, but rather bits of a carcass or sometimes just a crowd of bird butts with no carcass visible. We are using the carcass information to help us understand if there is or is not a carcass present when the birds are seen, and how close birds are to the biggest chunk that is the center of action, but we are not looking for fine-scale information on how many bits, etc. So, the best thing to do is to mark the biggest piece of a carcass and not worry about marking each individual bit. If you don’t see a carcass, but think one is there by the aggregation of condor butts, just mark your best guess for where you think the carcass is in the middle of the action.</p>
    '''

    markingOther: '''
      <h3>How to mark ‘other’</h3>
      <p>With the new added ‘other’ option you can now use this to designate any unusual creature (human or otherwise) you see in the photos! Some of the most common 'other' animals we have seen thus far are:</p>
      <p>mountain lion, pig, bear, bobcat, cow, human, and rabbit</p>
      <p>If you see an animal that is not listed and would thus be 'other', mark the other option and then we would appreciate it if you tagged this photo with the name of the animal you see. Please use the following commonly used names so we can easily find and quantify them:</p>

      <ul>
        <li>#bear</li>
        <li>#bobcat</li>
        <li>#cow</li>
        <li>#human</li>
        <li>#mountainlion</li>
        <li>#owl</li>
        <li>#pig</li>
        <li>#rabbit</li>
        <li>#unknownbird</li>
        <li>#unknownmammal</li>
      </ul>

      <p>As a side benefit of this study we are interested in understanding what types and how often these other animals use the condor feeding stations, so tagging these photos will be very helpful! Below are some examples of other animals that we have seen:</p>

      <img src="./images/animals/human.jpg" />
      <p>#human</p>

      <img src="./images/animals/bear.jpg" />
      <p>#bear</p>

      <img src="./images/animals/pig.jpg" />
      <p>#pig</p>

      <img src="./images/animals/cow.jpg" />
      <p>#cow</p>
    '''

    poisoningRates: '''
      <h3>The data behind the lead poisoning rates</h3>

      <p>When a bio for a condor comes up, the "poisoning frequency" can be "rarely, occasionally, often, or chronically". We based this categorization on how often these condors are lead poisoned (with a blood lead >45 µg/dL), in periodic blood lead monitoring conducted by the Condor Recovery Team field biologists. We used a blood lead >45 µg/dL as condors are typically taken in for medical management, including chelation therapy if they have a blood lead >45 µg/dL (note that currently the threshold for clinical treatment of condors is a blood lead of >35 µg/dL). Most California condors have their blood lead tested ~2/year. The summaries are as follows:</p>

      <ul>
        <li><b>rarely:</b> the condor had a blood lead >45 µg/dL <10 % of the time</li>
        <li><b>occasionally:</b> the condor had a blood lead >45 µg/dL 10-35 % of the time</li>
        <li><b>often:</b> the condor had a blood lead >45 µg/dL 36-60 % of the time</li>
        <li><b>chronically:</b> the condor had a blood lead >45 µg/dL 60 % of the time</li>
      </ul>

      <p>Please note that these summaries are not necessarily up to date and there are some wily condors that haven't been captured, and thus haven’t had their blood lead tested, for greater than two years! So, this information is a summary of the most recent data we have for a bird, but please keep in mind that it might not be representative of the condor’s current lead exposure history.</p>
    '''

    credit: '''
      <p>Text by Zeka Kuspa, Photos courtesy of U.S. Fish and Wildlife Service and Devon Lang Pryor</p>
      <p>Sources:</p>
      <ul>
        <li>Sibley, David A., The Sibley Guide to Birds of North America, 2000. Chanticleer Press, New York.</li>
        <li>Ventana Wildlife Society website: http://ventanaws.org/species_condors_history/</li>
        <li>Pinnacles National Park website: http://www.nps.gov/pinn/naturescience/condor-viewing-tips.htm</li>
      </ul>
    '''

  science:
    title: 'Science'
    content: '''
      <h3>Overview</h3>
      <p>Condors are regularly released in several regions in California and are also frequently recaptured for medical care, including chelation for lead poisoning, which results from ingesting bullet fragments in carcasses from animals hunted with lead ammunition. Our project consists of hundreds of thousands of photographs taken by remotely triggered cameras at provided feeding stations. These feeding stations are sites, located in California, where uncontaminated animal carcasses are placed out for the birds to feed on, in part to keep the birds acclimated so they can be trapped regularly for health monitoring. Photos from these feeding stations are labor-intensive to process, and yet they provide some of the best data on the history of each bird’s behaviors and social interactions and also the best real-time information on the health of individual birds, since not all birds carry radio or GPS transmitters. Currently, managers glean only immediate health data from these photos, although the photographs contain more information that could be used to better understand the social interactions, individual personalities of condors, and the ecology of this highly endangered species.</p>
      <h3>Data use and accessibility</h3>
      <p>Condors roost and forage in groups and group membership appears to be at least somewhat fluid on a daily basis, although mated pairs often forage together. Individuals foraging together may have a similar risk of being lead poisoned if they jointly ingest contaminated meat, especially if lead ammunition fragments are spread throughout carcasses. Alternatively, dominant individuals may exhibit the highest lead levels because they have first access to the bullet entry site, where the tough hide is pierced. For birds that have not reached full adult status, dominance is generally determined by age; among adults, dominance appears to be influenced by age as well as personality traits. If dominance increases lead ingestion, lead levels should increase with age up until adult status is attained. However, exploration and thus exposure to non-provided food items may increase with age, which would also result in a pattern of increasing lead levels with age.</p>
      <p>Our project goal is to gain a better understanding of whether observed foraging associations and other patterns of feeding station use predicted blood lead levels in California condors. We plan to assess the likelihood that associations at feeding stations predict foraging associations at wild locations, as well as evaluate the strength of social structuring and the temporal scale of associations in feeding groups. We will then test for whether age, sex, and rearing method predicted associations and the likelihood of feeding at feeding stations. Finally, we will evaluate whether age and associations between individuals predicted elevated blood lead levels.</p>
      <p>From the data collected by Condor Watch, we plan to generate a social network map of the condor population free-flying within California. As the project gathers more data, social network maps will evolve. Detailed data on interactions between individuals in wild populations are rare. Therefore, we anticipate that these data will be of considerable interest to multiple groups of scientists--those interested in: patterns of social interactions; the effects of learning on reintroduction efforts; and ecotoxicological problems in wild species. Data will be publically available through appendices in one or more scientific journal publications. We will also create a registry in the Knowledge Network for Biocomplexity (KNB) database. KNB was created with input from National Center for Ecology and Statistics and is a go-to point for ecologists looking for appropriate datasets for testing novel analyses.</p>
      <h3>Preliminary findings on why this project is important</h3>
      <p>We completed a preliminary analysis of data collected at proffered feeding stations equipped with still and video cameras in Pinnacles National Park in California, USA. Condor associations were relatively fluid through time, with the probability of any two currently-associated individuals being associated in the future remaining constant for about a month then slowly declining towards rates expected from random or no association behavior. Association rates among pairs of condors at feeding stations did not predict the probability that both exhibited elevated lead levels. However, we plan to test this prediction with the larger data set generated through Condor Watch to determine if our lack of an association was due to our small preliminary sample size.</p>
      <p>The strength of an individual’s social connections was negatively related to age. However, more socially connected individuals had a greater probability of elevated blood lead after accounting for age and site effects. Thus, we feel that data generated from Condor Watch will be valuable to help determine factors that can predict a condor’s lead poisoning risk, as well as understand condor social network behavior more generally.</p>
    '''

  about:
    title: 'About the project'
    summary: '''
      California condors are the largest North American terrestrial bird and one of the world’s rarest species. Condor populations collapsed to only 22 individuals in the 1980s before being captured, bred in captivity, and released again to reform wild populations. We are working to understand the threats to this species, and how to plan for its continued recovery from the brink of extinction.
    '''
    content: '''
      <p>California condors (<i>Gymnogyps californianus</i>) are one of the world’s most endangered bird species with a global population approaching only a few dozen birds in the early 1980s. Despite successful captive breeding and release efforts in recent years, the condor population remain heavily managed because they are frequently poisoned by lead from bullet fragments ingested in scavenged carcasses. Condor release sites, managed by the U.S. Fish and Wildlife Service, National Park Service and Ventana Wildlife Society, offer uncontaminated carcasses to birds as a way to lure them back for medical care and regular management activities. Release sites are equipped with automatically triggered cameras that have captured photographs of condors in the past 10 years. The Condor Watch project will analyze these photographs in order to understand how the personalities and social status of individual birds may predispose them to lead poisoning and to eventually gather critical real-time information on the health and status of these highly vulnerable birds.</p>
    '''

  organizations:
    msuEco:
      name: 'Montana State University Department of Ecology'
    pinnacles:
      name: 'Pinnacles National Park'
    uCaliSdBio:
      name: 'University of California San Diego Division of Biological sciences, Ecology, Behavior, and Evolution Section.'
    uCaliScMicro:
      name: 'University of California Santa Cruz Department of Microbiology and Environmental Toxicology'
    uColoEnv:
      name: 'University of Colorado Department of Environmental Studies'
    uColoMusNatHist:
      name: 'University of Colorado Museum of Natural History'
    uNebLinc:
      name: 'University of Nebraska-Lincoln School of Biological Sciences'
    usfwsCaliCondReco:
      name: 'U.S. Fish and Wildlife Service California Condor Recovery Program'
    vws:
      image: './images/logos/vws.png'
      name: 'Ventana Wildlife Society'
      url: 'http://ventanaws.org/'
    tnc:
      image: './images/logos/tnc.jpg'
      name: 'The Nature Conservancy'
    sbZoo:
      image: './images/logos/sbZoo.jpg'
      name: 'Santa Barbara Zoo'

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

    kurle:
      name: 'Carolyn Kurle'
      image: '//placehold.it/100.png'
      description: '''
        Carolyn is an Assistant Professor in the Ecology, Behavior, and Evolution Section of the Division of Biological Sciences at the University of California San Diego. Carolyn's research interests include reconstructing vertebrate foraging and migration patterns using stable isotope analysis and understanding the role of trophic interactions in structuring ecological communities. She has contributed to understanding the foraging ecology of threatened or endangered species including Steller sea lions, rock iguanas, northern fur seals, sea turtles, and California condors. Carolyn brings her expertise on foraging behavior to Condor Watch and will help examine how social status and frequency of observation at feeding stations is related to how much of a carcass a condor actually eats.
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
    content: '''
      <h3>Can I use Condor Watch in the classroom?</h3>
      <p>Yes! Condor Watch, just like all the Zooniverse projects, offers students a unique opportunity to explore real scientific data, while making a contribution to cutting edge research. We would like to stress that as each image is marked by multiple volunteers, it really does not matter if your students don't mark all the features correctly. That being said, the task itself is simple enough that we believe most people can take part and make a worthwhile contribution regardless of age.</p>
      <h3>What resources are there to support use in the classroom?</h3>
      <p>Videos are a great tool to introduce students to Condor Watch.  Here are a couple of our favorites:</p>
      <ul>
        <li>The Condor’s Shadow documentary covers the details behind this project, <a href="http://www.thecondorsshadow.com/index.html">http://www.thecondorsshadow.com/index.html</a></li>
        <li>The Condor’s Shadow documentary offers many video clips to chose from, <a href="http://www.thecondorsshadow.com/film_clips.html">http://www.thecondorsshadow.com/film_clips.html</a></li>
      </ul>
      <p>There is also a podcast featuring one of the science team members, Myra Finkelstein:</p>
      <ul>
        <li><a href="http://www.pnas.org/site/misc/myraFinkelsteinPodcast.mp3">http://www.pnas.org/site/misc/myraFinkelsteinPodcast.mp3</a></li>
      </ul>
      <p>You may also be able to find activities provided by some of the science team’s partners:</p>
      <ul>
        <li>Pinnacles National Park - <a href="http://www.nps.gov/pinn/naturescience/condors.htm">http://www.nps.gov/pinn/naturescience/condors.htm</a></li>
        <li>Santa Barbara Zoo - <a href="http://www.sbcondors.com/">http://www.sbcondors.com/</a></li>
        <li>Oregon Zoo - <a href="http://www.oregonzoo.org/conserve/species-recovery-and-conservation/california-condors">http://www.oregonzoo.org/conserve/species-recovery-and-conservation/california-condors</a></li>
        <li>Ventana Wildlife Society - <a href="http://www.ventanaws.org/index.htm">http://www.ventanaws.org/index.htm</a></li>
      </ul>
      <p>The Zooniverse has launched <a href="http://www.zooteach.org/">ZooTeach</a> where educators can find and share educational resources relating to Condor Watch and the other Zooniverse citizen science projects. Check out resources created for Condor Watch. Have any ideas for how to use the project in the classroom? Please share your lesson ideas or resources on ZooTeach!</p>
      <h3>How can I keep up to date with education and Condor Watch?</h3>
      <p><a href="http://blog.condorwatch.org/">The Condor Watch blog</a>, as well as the partner Facebook pages below, are great places to keep up to date with the latests science results, but there is also a <a href="http://education.zooniverse.org/">Zooniverse Education Blog</a> as well as a <a href="https://twitter.com/ZooTeach">@ZooTeach</a> Twitter feed.</p>
      <p>Partner Facebook Pages:</p>
      <ul>
        <li><a href="https://www.facebook.com/TheCondorCave">https://www.facebook.com/TheCondorCave</a></li>
        <li><a href="https://www.facebook.com/VentanaWildlifeSociety">https://www.facebook.com/VentanaWildlifeSociety</a></li>
        <li><a href="https://www.facebook.com/pages/Pinnacles-National-Park/106787909380024">https://www.facebook.com/pages/Pinnacles-National-Park/106787909380024</a></li>
      </ul>
    '''

  dateFormat: '$month $day, $year'
  months:
    jan: 'January'
    feb: 'February'
    mar: 'March'
    apr: 'April'
    may: 'May'
    jun: 'June'
    jul: 'July'
    aug: 'August'
    sep: 'September'
    oct: 'October'
    nov: 'November'
    dec: 'December'
