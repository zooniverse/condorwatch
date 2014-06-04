$ = window.jQuery
possibleTagColors = require './possible-tag-colors'

module.exports = $.get('./condor-tags.tsv').pipe (tabSeparated) ->
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

    pattern = values.shift()
    noPattern = !!pattern.match(/none/i)?

    underlined = !!pattern.match(/underline/i)?
    object.underlined = underlined

    dots = if noPattern or underlined
      0
    else
      parseFloat pattern.match(/(\d+) dot/i)?[1]

    object.dots = dots ? null

    leftColor = values.shift().toLowerCase()
    object.color.push leftColor if leftColor in possibleTagColors

    rightColor = values.shift().toLowerCase()
    object.color.push rightColor if rightColor in possibleTagColors

    object.color = null if object.color.length is 0

    values.shift() # Left transmitter not used
    values.shift() # Right transmitter not used

    object.source = values.shift()

    object

  rows
