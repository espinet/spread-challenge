class LinearInterpolator
  # Uses linear interpolation to calculate y for x when providing two surrounding points. This only
  # returns the y value.
  # 
  # ==== Attributes
  #
  # +x+ - The x coordinate for the y value to be solved.
  # +point1+ - A coordinate point in the format { x: 1, y: 2 }. This point should have an x value
  # smaller than the x value being used to solve y.
  # +point1+ - A coordinate point in the format { x: 1, y: 2 }. This point should have an x value
  # larger than the x value being used to solve y.
  #
  # ==== Examples
  # 
  #   LinearInterpolator.calculate(0.5, { x: 0, y: 0}, { x: 1, y: 1 }) #=> 0.5
  def self.calculate(x, point1, point2)
    ((x - point1[:x]) * (point2[:y] - point1[:y]) / (point2[:x] - point1[:x])) + point1[:y]
  end
end
