class BondCollection
  include Enumerable

  attr_accessor :bonds

  def initialize(records = [])
    @bonds = Array(records).map do |record|
      if record.is_a?(Hash)
        Bond.new(record)
      elsif record.is_a?(Bond)
        record
      else
        raise ArgumentError.new('requires raw bond data or a Bond')
      end
    end.uniq.sort

    @bonds.freeze
  end

  def add(records)
    BondCollection.new(@bonds.dup.push(records))
  end

  def filter(attributes)
    raise ArgumentError.new('only one attribute can be filtered at a time') if attributes.keys.count > 1

    filtered = @bonds.select { |bond| bond.send(attributes.keys[0]) == attributes.values[0] }
    BondCollection.new(filtered)
  end

  def [](index)
    @bonds[index]
  end

  def index(bond)
    @bonds.index(bond)
  end

  def count
    @bonds.count
  end

  def each(&block)
    @bonds.each(&block)
  end
end
