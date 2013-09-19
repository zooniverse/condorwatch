BaseModel = require 'zooniverse/models/base-model'

class Annotation extends BaseModel
  x: 0
  y: 0
  imageWidth: 0
  imageHeight: 0
  tag: ''
  proximity: 0.5

  set: (property, value) ->
    if typeof property is 'string'
      @[property] = value
      @trigger 'change', property, value
    else
      properties = property
      @set property, value for property, value of properties

module.exports = Annotation
