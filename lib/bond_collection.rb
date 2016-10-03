# An enumerable and immutable class for managing Bonds.
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

  # Creates a new BondCollection with the old records and new records in sorted order by term.
  #
  # ==== Attributes
  #
  # +records+ - Can be a Bond or a hash which has the valid key value pairs to become a Bond. This
  # can also be a single object or an array.
  #
  # ==== Examples
  #
  #   BondCollection.new.add([{...}, ...]) #=> BondCollection
  def add(records)
    BondCollection.new(@bonds.dup.push(records))
  end

  # Returns a new BondCollection matching the attributes specified in the arguments.
  #
  # ==== Attributes
  #
  # +hash+ - An individual key value pair that can be found in a Bond's attributes. Valid keys are
  # bond, type, term, yield.
  #
  # ==== Examples
  #
  #   BondCollection.new.filter({ type: 'government' }) #=> BondCollection
  def filter(attributes)
    raise ArgumentError.new('only one attribute can be filtered at a time') if attributes.keys.count > 1

    filtered = @bonds.select { |bond| bond.send(attributes.keys[0]) == attributes.values[0] }
    BondCollection.new(filtered)
  end

  # Return a bond at the provided index.
  def [](index)
    @bonds[index]
  end

  # Returns the index of a bond in a collection.
  def index(bond)
    @bonds.index(bond)
  end

  # Returns the number of bonds in a collection.
  def count
    @bonds.count
  end

  def each(&block)
    @bonds.each(&block)
  end
end
