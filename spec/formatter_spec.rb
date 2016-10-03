require_relative '../lib/formatter'

describe Formatter do
  describe 'parse' do
    let(:hash) { { 'term' => '10.3 years', 'yield' => '1.30%' } }

    it 'formats "X years" from a string to "X" as a decimal in days' do
      expect(Formatter.parse(hash)['term']).to equal(10.3 * 365)
    end

    it 'formats "Y%" from a string to "Y / 100" as a decimal' do
      expect(Formatter.parse(hash)['yield']).to be_within(0.0000001).of(0.013)
    end
  end

  describe 'prettify' do
    let(:hash) { { spread_to_benchmark: 0.015, spread_to_curve: 0.022 } }

    it 'formats yield to be a % as X% for benchmark' do
      expect(Formatter.prettify(hash, :spread_to_benchmark)[:spread_to_benchmark]).to match('1.50%')
    end

    it 'formats yield to be a % as X% for curve' do
      expect(Formatter.prettify(hash, :spread_to_curve)[:spread_to_curve]).to match('2.20%')
    end
  end
end
