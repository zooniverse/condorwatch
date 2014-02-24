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

    patterns = values.shift().toUpperCase()

    dots = parseFloat patterns.match(/(\d+) dot/i)?[1]
    dots = null if isNaN dots
    dots = 0 if patterns is 'NONE'
    object.dots = dots

    underlined = !!patterns.match(/underline/i)?
    object.underlined = underlined

    leftColor = values.shift().toLowerCase()
    object.color.push leftColor if leftColor in possibleTagColors

    rightColor = values.shift().toLowerCase()
    object.color.push rightColor if rightColor in possibleTagColors

    object.color = null if object.color.length is 0

    object

  rows

guessCondor = (givens, callback) ->
  reducedGivens = {}
  for property, value of givens
    if property in ['label', 'color', 'dots', 'underlined'] and value?
      reducedGivens[property] = value

  $.when(getTags).then (tags) ->
    matches = tags.filter (values) ->
      for key, givenValue of reducedGivens
        unless values[key]?
          continue

        if values[key] instanceof Array
          return false unless givenValue in values[key]
        else
          return false unless values[key] is givenValue

      return true

    ids = [[], matches...].reduce (reduced, match) ->
      unless match.id in reduced
        reduced.push match.id
      reduced

    callback? ids
    ids

window.guessCondor = guessCondor if +location.port > 1023
module.exports = guessCondor
