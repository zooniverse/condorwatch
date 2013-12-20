$ = window.jQuery

HATCH_STATES = ['in-the-wild', 'in-captivity']
SEXES = ['female', 'male']
REARERS = ['biological-parents', 'foster-parents', 'zookeeper']
POISONINGS = ['rarely', 'sometimes', 'often']

getCondors = $.get('./condors.csv').pipe (condorTableText) ->
  condorTableRows = condorTableText.split('\n').filter Boolean
  condorTableRows.shift() # Throw away the header

  condors = {}

  condorTableRows.forEach (line) ->
    values = line.split '\t'
    id = values.shift()
    condors[id] =
      inTagTable: values.shift()
      father: values.shift()
      mother: values.shift()
      hatchedAt: new Date values.shift()
      hatchState: HATCH_STATES[values.shift()]
      hatchLocation: values.shift()
      sex: SEXES[values.shift()]
      rearedBy: REARERS[values.shift()]
      releasedAt: new Date values.shift()
      poisoned: POISONINGS[values.shift()]
      firstBredAt: new Date values.shift()
      chicks: parseFloat values.shift()
      mateIn1999: values.shift()
      mateIn2000: values.shift()
      mateIn2001: values.shift()
      mateIn2002: values.shift()
      mateIn2003: values.shift()
      mateIn2004: values.shift()
      mateIn2005: values.shift()
      mateIn2006: values.shift()
      mateIn2007: values.shift()
      mateIn2008: values.shift()
      mateIn2009: values.shift()
      mateIn2010: values.shift()
      mateIn2011: values.shift()
      mateIn2012: values.shift()
      diedAt: new Date values.shift()

  condors

getCondorBio = (id, callback) ->
  getCondors.then (condors) ->
    callback? condors[id]

window.getCondorBio = getCondorBio if +location.port > 1023
module.exports = getCondorBio
