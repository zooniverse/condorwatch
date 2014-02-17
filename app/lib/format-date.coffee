translate = require 't7e'

formatDate = (date) ->
  date = new Date date unless date instanceof Date
  [_, month, day, year] = date.toString().split /\s/
  month = "months.#{month.toLowerCase()}"
  day = parseFloat day
  translate 'span', 'dateFormat', $month: month, $day: day, $year: year, title: date

module.exports = formatDate
