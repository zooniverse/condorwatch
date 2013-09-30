getOctagonPoints = (radius) ->
  angled = Math.sqrt Math.pow(radius, 2) / 2

  """
    0, -#{radius}
    #{angled}, -#{angled}
    #{radius}, 0
    #{angled}, #{angled}
    0, #{radius}
    -#{angled}, #{angled}
    -#{radius}, 0
    -#{angled}, -#{angled}
  """.replace /\n/g, ' '

module.exports = getOctagonPoints
