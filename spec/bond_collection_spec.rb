require_relative '../lib/bond_collection'

describe BondCollection do
  before do
    records = [
      { bond: 'C1', type: 'corporate', term: 3759.5, yield: 0.053 },
      { bond: 'G1', type: 'government', term: 3431, yield: 0.037 },
      { bond: 'G2', type: 'government', term: 4380, yield: 0.048 },
      { bond: 'G3', type: 'government', term: 5949.5, yield: 0.055 }
    ]

    @collection = BondCollection.new(records)
  end

  describe '#new' do
    it 'contains five records' do
      expect(@collection.count).to equal(4)
    end

    it 'is sorted ascending by term' do
      bonds = @collection.map { |bond| bond.bond }
      expect(bonds).to match_array(%w(G1 C1 G2 G3))
    end
  end

  describe '.add' do
    let(:bond) { { bond: 'C2', type: 'corporate', term: 5548, yield: 0.083 } }

    it 'returns a new collection' do
      new_collection = @collection.add(bond)

      expect(new_collection.is_a?(BondCollection)).to be true
      expect(new_collection).not_to equal(@collection)
    end

    it 'adds the new bond to the correct index' do
      new_collection = @collection.add(bond)
      expect(new_collection.bonds[3].bond).to match('C2')
    end
  end

  describe '.filter' do
    context 'when filtering for government bonds' do
      it 'returns a collection with three bonds' do
        expect(@collection.filter(type: 'government').count).to equal(3)
      end

      it 'keeps the bond in sorted order' do
        government_bonds = @collection.filter(type: 'government').map(&:bond)
        expect(government_bonds).to match_array(%w(G1 G2 G3))
      end
    end
  end

  describe '[]' do
    it 'returns the element at the specified index' do
      expect(@collection[1].bond).to match('C1')
    end
  end

  describe '.index' do
    it 'returns the index of the provided object' do
      object = @collection[2]
      expect(@collection.index(object)).to equal(2)
    end
  end
end
