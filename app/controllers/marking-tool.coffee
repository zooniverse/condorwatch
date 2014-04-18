{Mark, ToolControls, Tool} = require 'marking-surface'
$ = window.jQuery
MagnifierPointTool = require 'marking-surface/lib/tools/magnifier-point'

class MarkingMark extends Mark
  isValid: ->
    @animal? and @proximity?

  limit: (n, direction) ->
    dimensions = @_surface.el.getBoundingClientRect()
    Math.min dimensions[direction], Math.max 0, n

  'set x': (value) ->
    @limit value, 'width'

  'set y': (value) ->
    @limit value, 'height'

class MarkingToolControls extends ToolControls
  template: '''
    <button name="toggle" title="[`]"></button>
  '''

  constructor: ->
    super
    @toggleButton = $(@el).find 'button[name="toggle"]'
    @toggleButton.on 'click', => @tool.toggle()

    @tool.on 'collapse', @collapse
    @tool.on 'expand', @expand
    @tool.on 'select', => setTimeout => @toggleButton.focus()

  onMouseDown: ->
    # Usually this selected the tool, but that breaks the toggle button.

  collapse: =>
    @toggleButton.html '<i class="fa fa-search-plus"></i>'

  expand: =>
    @toggleButton.html '<i class="fa fa-search-minus"></i>'

class MarkingTool extends MagnifierPointTool
  @Mark: MarkingMark
  @Controls: MarkingToolControls

  stroke: 'currentColor'
  radius: 100
  zoom: 1.1

  collapsed: false

  initialize: ->
    super
    @mark._surface = @surface

  select: ->
    unless @surface.selection is @
      if @collapsed then @collapse() else @expand()

    super
    @disc.attr r: @radius
    @clipCircle.attr r: @radius

  deselect: ->
    super
    @disc.attr r: 7, strokeDasharray: []
    @clipCircle.attr r: 7

  expand: ->
    @root.toggleClass 'collapsed', false
    @image.attr 'opacity', 1
    @disc.attr strokeDasharray: []
    @collapsed = false
    @trigger 'expand'

  collapse: ->
    @root.toggleClass 'collapsed', true
    @image.attr 'opacity', 0
    @disc.attr strokeDasharray: [@strokeWidth, @strokeWidth]
    @collapsed = true
    @trigger 'collapse'

  toggle: ->
    if @collapsed then @expand() else @collapse()

  render: ->
    super
    @root.toggleClass 'invalid', not @mark.isValid()

module.exports = MarkingTool
