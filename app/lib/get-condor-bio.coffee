$ = window.jQuery

nullify = (value) ->
  if value in ['', '#N/A'] or (value instanceof Date and isNaN value)
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
      releasedAt: nullify new Date values.shift()
      diedAt: nullify new Date values.shift()
      deathAge: parseFloat values.shift()
      fatherId: values.shift()
      motherId: values.shift()
      poisoned: values.shift()
      firstBredAt: nullify new Date values.shift()
      chicks: parseFloat values.shift()
      mateIn1999: nullify values.shift()
      mateIn2000: nullify values.shift()
      mateIn2001: nullify values.shift()
      mateIn2002: nullify values.shift()
      mateIn2003: nullify values.shift()
      mateIn2004: nullify values.shift()
      mateIn2005: nullify values.shift()
      mateIn2006: nullify values.shift()
      mateIn2007: nullify values.shift()
      mateIn2008: nullify values.shift()
      mateIn2009: nullify values.shift()
      mateIn2010: nullify values.shift()
      mateIn2011: nullify values.shift()
      mateIn2012: nullify values.shift()
      idInTags: values.shift()

  condors

getCondorBio = (id, callback) ->
  getCondors.then (condors) ->
    callback? condors[id]
    condors[id]

window.getCondorBio = getCondorBio if +location.port > 1023
module.exports = getCondorBio
