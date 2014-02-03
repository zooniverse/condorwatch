{Mark, ToolControls, Tool} = require 'marking-surface'
$ = window.jQuery
MagnifierPointTool = require 'marking-surface/lib/tools/magnifier-point'

class MarkingMark extends Mark
  isValid: ->
    if @animal is 'carcassOrScale'
      true
    else if @animal? and @proximity?
      true
    else
      false

class MarkingToolControls extends ToolControls
  template: '''
    <button name="toggle">±</button>
  '''

  constructor: ->
    super
    @$el = $(@el)
    @$el.on 'click', 'button[name="toggle"]', => @tool.toggle()

  onMouseDown: ->
    # Usually this selected the tool, but that breaks the toggle button.

class MarkingTool extends MagnifierPointTool
  @Mark: MarkingMark
  @Controls: MarkingToolControls

  stroke: 'currentColor'
  radius: 100
  zoom: 1.1

  collapsed: false

  select: ->
    unless @surface.selection is @
      @expand()

    super
    @disc.attr r: @radius
    @clipCircle.attr r: @radius

  deselect: ->
    super
    @disc.attr r: 7
    @clipCircle.attr r: 7
    @collapse()

  expand: ->
    @root.toggleClass 'collapsed', false
    @image.attr 'opacity', 1
    @collapsed = false

  collapse: ->
    @root.toggleClass 'collapsed', true
    @image.attr 'opacity', 0
    @collapsed = true

  toggle: ->
    if @collapsed then @expand() else @collapse()

  render: ->
    super
    @root.toggleClass 'invalid', not @mark.isValid()

module.exports = MarkingTool
