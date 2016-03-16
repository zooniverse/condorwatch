Subject = require 'zooniverse/models/subject'

module.exports = ->
  subject = new Subject
    id: '534c3d6ed31eae0543005b3f'
    zooniverse_id: 'ACW0005e7i'
    location: standard: 'https://www.condorwatch.org/subjects/standard/534c3d6ed31eae0543005b3f.JPG'
    tutorial: true
    workflow_ids: ['52e2cba83ae7401db5000002']

  subject.select()
