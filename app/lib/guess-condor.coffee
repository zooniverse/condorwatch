$ = window.jQuery
possibleTagColors = require './possible-tag-colors'

getTags = $.get('./condor-tags.csv').pipe (tabSeparated) ->
  rows = tabSeparated.split('\n').filter Boolean
  rows.shift(); rows.shift() # Throw away the keys.

  rows = rows.map (row) ->
    row.split '\t'

  rows = rows.map (values) ->
    object = {}

    object.id = "#{values.shift()}"

    year = parseFloat values.shift()
    object.year = year if year

    object.label = "#{values.shift()}"

    object.color = []
    color = values.shift().toLowerCase()
    object.color.push color if color in possibleTagColors

    patterns = values.shift()
    dots = parseFloat patterns.match(/(\d+) dot/i)?[1]
    underlined = patterns.match(/underline/i)?
    object.dots = dots if dots
    object.underlined = underlined if underlined

    leftColor = values.shift().toLowerCase()
    rightColor = values.shift().toLowerCase()
    if leftColor in possibleTagColors and leftColor not in object.color
      object.color.push leftColor
    if rightColor in possibleTagColors and rightColor not in object.color
      object.color.push rightColor

    object

  rows

guessCondor = (given, callback) ->
  getTags.then (tags) ->
    matches = tags.filter (values) ->
      for key, givenValue of given when givenValue?
        return false unless values[key] is givenValue or (values[key] instanceof Array and givenValue in values[key])
      return true

    ids = [[], matches...].reduce (reduced, match) ->
      unless match.id in reduced
        reduced.push match.id
      reduced

    callback? ids

window.guessCondor = guessCondor if +location.port > 1023
module.exports = guessCondor
