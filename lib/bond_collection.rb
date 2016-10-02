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
    end.sort
  end

  def add(records)
    BondCollection.new(@bonds.push(records))
  end

  # This method could be expanded so the query could be a lot more flexible if needed.
  def filter(attributes)
    raise ArgumentError.new('only one attribute can be filtered at a time') if attributes.keys.count > 1

    filtered = @bonds.select { |bond| bond.send(attributes.keys[0]) == attributes.values[0] }
    BondCollection.new(filtered)
  end

  def count
    @bonds.count
  end

  def each(&block)
    @bonds.each(&block)
  end
end