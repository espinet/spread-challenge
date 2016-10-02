require_relative '../lib/bond'

describe Bond do
  before do
    @bond1 = Bond.new({ bond: 'G1', type: 'government', term: 3431, yield: 0.037 })
    @bond2 = Bond.new({ bond: 'G2', type: 'government', term: 4380, yield: 0.048 })
  end

  describe '>' do
    it 'returns true if the term is larger than its comparator' do
      expect(@bond2 > @bond1).to equal(true)
    end

    it 'returns false if the term is not larger than its comparator' do
      expect(@bond2 < @bond1).to equal(false)
    end
  end
end
