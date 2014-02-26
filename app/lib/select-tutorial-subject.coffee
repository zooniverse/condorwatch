Subject = require 'zooniverse/models/subject'

module.exports = ->
  subject = new Subject
    location: standard: 'http://zooniverse-demo.s3-website-us-east-1.amazonaws.com/condors/subjects/standard/5282a62b3ae74095c1002da0.jpg'
    tutorial: true

  subject.select()
