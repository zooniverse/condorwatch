{Tool} = require 'marking-surface'
MagnifierPointTool = require 'marking-surface/lib/tools/magnifier-point'
getOctagonPoints = require '../lib/get-octagon-points'

class MarkingTool extends MagnifierPointTool
  @Controls: require 'marking-surface/lib/tools/default-controls'

  radius: 100
  zoom: 1

  select: ->
    super
    @disc.attr r: @radius, fill: 'transparent'
    @clipCircle.attr 'r', @radius
    @image.attr 'opacity', 1

  deselect: ->
    super
    @disc.attr r: 7, fill: 'blue'
    @clipCircle.attr 'r', 5
    @image.attr 'opacity', 0

module.exports = MarkingTool
