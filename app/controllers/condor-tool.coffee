{Tool} = require 'marking-surface'
MagnifierPointTool = require 'marking-surface/lib/tools/magnifier-point'
getOctagonPoints = require '../lib/get-octagon-points'

class CondorTool extends MagnifierPointTool
  @Controls: require './condor-tool-controls'

  radius: 50
  zoom: 1

module.exports = CondorTool
