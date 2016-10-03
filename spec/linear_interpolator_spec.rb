require_relative '../lib/linear_interpolator'

describe LinearInterpolator do
  describe '.calculate' do
    it 'should find the midpoint between point 1 and point 2' do
      expect(LinearInterpolator.calculate(0.5, { x: 0, y: 0 }, { x: 1, y: 1 })).to equal(0.5)
    end
  end
end

