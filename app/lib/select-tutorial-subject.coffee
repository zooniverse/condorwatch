Subject = require 'zooniverse/models/subject'

module.exports = ->
  subject = new Subject
    id: '5282a62b3ae74095c1002da0'
    zooniverse_id: 'TODO_TUTORIAL_SUBJECT_ZOONIVERSE_ID'
    location: standard: 'http://zooniverse-demo.s3-website-us-east-1.amazonaws.com/condors/subjects/standard/5282a62b3ae74095c1002da0.jpg'
    tutorial: true
    workflow_ids: ['52e2cba83ae7401db5000002']

  subject.select()
