$ = window.jQuery

nullify = (value) ->
  if value in ['', '#N/A']
    null
  else
    value

getCondors = $.get('./condors.csv').pipe (tabbed) ->
  rows = tabbed.split('\n').filter Boolean
  rows.shift() # Throw away the header.

  condors = {}

  rows.forEach (line) ->
    values = line.split '\t'
    id = values.shift()
    condors[id] =
      id: id
      sex: nullify values.shift()
      hatchedAt: new Date values.shift()
      rearedBy: values.shift()
      hatchLocation: values.shift()
      releasedAt: new Date values.shift()
      diedAt: new Date values.shift()
      fatherId: values.shift()
      motherId: values.shift()
      poisoned: values.shift()
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
      idInTags: values.shift()

  condors

getCondorBio = (id, callback) ->
  getCondors.then (condors) ->
    callback? condors[id]
    condors[id]

window.getCondorBio = getCondorBio if +location.port > 1023
module.exports = getCondorBio
