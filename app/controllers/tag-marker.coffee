BaseController = require 'zooniverse/controllers/base-controller'

class TagMarker extends BaseController
  annotation: null

  className: 'tag-marker'
  template: require '../views/tag-marker'

  constructor: ->
    super
    @annotation.on 'change', @onAnnotationChange
    @annotation.on 'destroy', @onAnnotationDestroy

    setTimeout =>
      for property in ['x', 'y', 'tag', 'proximity']
        @onAnnotationChange null, property, @annotation[property]

  onAnnotationChange: (e, property, value) =>
    switch property
      when 'x', 'y', 'imageWidth', 'imageHeight'
        parent = @el.parent()
        @el.offset
          left: @annotation.x * parent.width()
          height: @annotation.y * parent.height()

        console.log parent, parent.width(), parent.height()

      when 'proximity'
        console.log 'Reposition proximity thumb', value

      when 'tag'
        console.log 'Set tag input value', value

  onAnnotationDestroy: =>
    @destroy()

module.exports = TagMarker
