class LinearInterpolator
  def self.calculate(x, point1, point2)
    ((x - point1[:x]) * (point2[:y] - point1[:y]) / (point2[:x] - point1[:x])) + point1[:y]
  end
end
