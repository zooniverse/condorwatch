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
    return unless @tag?

    if @mark.x? and @mark.y?
      @group.attr 'transform', "translate(#{@mark.x}, #{@mark.y})"
      @controls.moveTo @mark.x, @mark.y

    if @mark.proximity?
      radius = @tagRadius - ((@tagRadius / 2) * (@mark.proximity))
      @tag.attr 'points', getOctagonPoints radius

    @label.attr 'textContent', if @mark.tagHidden
      '?'
    else
      @mark.tag || '···'

    @label.attr
      x: @label.el.clientWidth / -2
      y: @label.el.clientHeight / 2

module.exports = CondorTool
