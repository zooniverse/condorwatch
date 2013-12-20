getTags = $.get('./condor-tags.csv').pipe (tabSeparated) ->
  rows = tabSeparated.split('\n').filter Boolean
  rows.shift() # Throw away the keys.
  rows = rows.map (row) -> row.split '\t'

  rows = rows.map (values) ->
    id: values.shift()
    year: parseFloat values.shift()
    label: values.shift()
    color: values.shift()
    dots: parseFloat values.shift()
    underline: !!values.shift()

  rows

guessCondor = (given, callback) ->
  getTags.then (tags) ->
    matches = tags.filter (values) ->
      for key, givenValue of given
        return false unless values[key] is givenValue
      return true

    ids = matches.map (match) -> match.id

    callback? ids

window.guessCondor = guessCondor if +location.port > 1023
module.exports = guessCondor
