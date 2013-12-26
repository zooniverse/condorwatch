{Tool} = require 'marking-surface'
MagnifierPointTool = require 'marking-surface/lib/tools/magnifier-point'
getOctagonPoints = require '../lib/get-octagon-points'

class MarkingTool extends MagnifierPointTool
  @Controls: require './marking-tool-controls'

  radius: 60
  zoom: 1.25

  render: ->
    proximity = @mark.proximity
    proximity ?= 0.5
    newRadius = (@constructor::radius / 2) * (2 - proximity)

    if newRadius is @radius
      super
    else
      @radius = newRadius
      @redraw()

module.exports = MarkingTool
