tagsTable = require './tags-table'

guessCondor = (givens, callback) ->
  reducedGivens = {}
  for property, value of givens
    if property in ['label', 'color', 'dots', 'underlined', 'source'] and value?
      reducedGivens[property] = value

  tagsTable.then (tags) ->
    console?.group 'Searching for condor given', JSON.stringify reducedGivens

    matches = tags.filter (values) ->
      for key, givenValue of reducedGivens
        unless values[key]?
          continue

        if values[key] instanceof Array
          return false unless givenValue in values[key]
        else if typeof givenValue is 'function'
          return false unless givenValue.call this, values[key]
        else if typeof givenValue is 'string'
          return false unless values[key]?.replace?(/\W/, '') is givenValue.replace(/\W/, '')
        else
          return false unless values[key] is givenValue

      return true

    ids = [[], matches...].reduce (reduced, match) ->
      unless match.id in reduced
        reduced.push match.id
      reduced

    unless reducedGivens.label
      ids = []

    console?.log "Found #{ids.length} condor(s)", JSON.stringify ids
    console?.groupEnd()

    callback? ids
    ids

window.guessCondor = guessCondor
module.exports = guessCondor
