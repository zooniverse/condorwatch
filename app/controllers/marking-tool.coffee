{Tool} = require 'marking-surface'
MagnifierPointTool = require 'marking-surface/lib/tools/magnifier-point'
getOctagonPoints = require '../lib/get-octagon-points'

class MarkingTool extends MagnifierPointTool
  @Controls: require './marking-tool-controls'

  radius: 50
  zoom: 1

module.exports = MarkingTool
