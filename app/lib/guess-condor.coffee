tagsTable = require './tags-table'

guessCondor = (givens, callback) ->
  # Only try if we're given a label, because otherwise there's no point.
  if 'label' of givens
    reducedGivens = {}
    for property, value of givens
      if property in ['label', 'color', 'dots', 'underlined', 'source'] and value?
        reducedGivens[property] = value

  tagsTable.then (tags) ->
    if reducedGivens?
      console?.group 'Searching for condor given', reducedGivens

      matches = tags.filter (tagValues) ->
        for key, givenValue of reducedGivens
          # Ignore things that aren't defined in a tag.
          unless tagValues[key]?
            continue

          if tagValues[key] instanceof Array
            # Colors are stored in an array.
            unless givenValue in tagValues[key]
              return false
          else if typeof givenValue is 'function'
            # Site ("source") can be Socal (given as a string)
            # or not Socal (given as a function filtering out Socal)
            unless givenValue.call this, tagValues[key]
              return false
          else if typeof givenValue is 'string'
            # Ignore non-word characters for the label.
            unless tagValues[key]?.replace?(/\W/, '') is givenValue.replace(/\W/, '')
              return false
          else
            # For everything else make sure it matches.
            unless tagValues[key] is givenValue
              return false

        return true

      ids = [[], matches...].reduce (reduced, match) ->
        unless match.id in reduced
          reduced.push match.id
        reduced

      console?.log "Found #{ids.length} condor(s)", JSON.stringify ids
      console?.groupEnd()

      callback? ids
      ids

    else
      callback? []
      []

window.guessCondor = guessCondor
module.exports = guessCondor
