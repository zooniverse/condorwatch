{Tool} = require 'marking-surface'
MagnifierPointTool = require 'marking-surface/lib/tools/magnifier-point'
getOctagonPoints = require '../lib/get-octagon-points'

class MarkingTool extends MagnifierPointTool
  @Controls: require 'marking-surface/lib/tools/default-controls'

  radius: 60
  zoom: 1.25

  select: ->
    super
    @disc.attr 'r', @radius
    @image.attr 'opacity', 1
    @disc.attr 'fill', 'transparent'

  deselect: ->
    super
    @disc.attr 'r', 7
    @image.attr 'opacity', 0
    @disc.attr 'fill', 'red'

module.exports = MarkingTool
