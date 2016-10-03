require_relative '../lib/spread_calculator'
require_relative '../lib/bond_collection'
require_relative '../lib/linear_interpolator'

describe SpreadCalculator do
  describe '.to_benchmark' do
    before do
      @corporate_bond = Bond.new({ bond: 'C1', type: 'corporate', term: 3759.5, yield: 0.053 })

      records = [
        { bond: 'G1', type: 'government', term: 3431, yield: 0.037 },
        { bond: 'G2', type: 'government', term: 4380, yield: 0.048 }
      ]
      @government_bonds = BondCollection.new(records)
    end

    it 'returns the correct spread' do
      benchmark = SpreadCalculator.to_benchmark(@corporate_bond, @government_bonds)

      expect(benchmark[:bond]).to match('C1')
      expect(benchmark[:benchmark]).to match('G1')
      expect(benchmark[:spread_to_benchmark]).to equal(0.016)
    end
  end

  describe '.to_curve' do
    before do
      @corporate_bond = Bond.new({ bond: 'C1', type: 'corporate', term: 3759.5, yield: 0.053 })

      records = [
        { bond: 'G1', type: 'government', term: 3431, yield: 0.037 },
        { bond: 'G2', type: 'government', term: 4380, yield: 0.048 },
        { bond: 'G3', type: 'government', term: 5949.5, yield: 0.055 }
      ]
      @government_bonds = BondCollection.new(records)
    end

    it 'returns the correct spread' do
      benchmark = SpreadCalculator.to_curve(@corporate_bond, @government_bonds)

      expect(benchmark[:bond]).to match('C1')
      expect(benchmark[:spread_to_curve]).to be_within(0.000009).of(0.0122)
    end
  end
end
