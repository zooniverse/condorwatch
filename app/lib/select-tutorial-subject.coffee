Subject = require 'zooniverse/models/subject'

module.exports = ->
  subject = new Subject
    location: standard: '//placehold.it/640x480'
    tutorial: true
  subject.select()
