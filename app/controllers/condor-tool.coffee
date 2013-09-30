{Tool} = require 'marking-surface'
getOctagonPoints = require '../lib/get-octagon-points'

class CondorTool extends Tool
  @Controls: require './condor-tool-controls'

  tagRadius: 25

  cursors:
    'tag': 'move'

  initialize: ->
    @tag = @addShape 'polygon.tag-marker'
    @label = @addShape 'text.tag-label', transform: 'translate(0, -3)'

  onInitialClick: (e) ->
    @onInitialDrag e

  onInitialDrag: (e) ->
    @['on *drag tag'] e

  'on *drag tag': (e) ->
    offset = @pointerOffset e
    @mark.set offset

  render: ->
    @group.attr 'transform', "translate(#{@mark.x}, #{@mark.y})"

    length = @tagRadius - ((@tagRadius / 2) * (@mark.proximity || 0.5))

    @tag.attr 'points', getOctagonPoints length

    @label.attr 'textContent', if @mark.tagHidden
      '?'
    else
      @mark.tag || '···'

    @label.attr
      x: @label.el.clientWidth / -2
      y: @label.el.clientHeight / 2

    @controls.moveTo @mark.x, @mark.y

module.exports = CondorTool
