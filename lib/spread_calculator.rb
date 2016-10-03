# A collection of spread calculation methods to compare corporate bonds and government bonds.
class SpreadCalculator
  # Used to calculate the spread_to_benchmark between a bond and a collection of candidate bonds.
  # 
  # ==== Attributes
  #
  # +bond+ - A Bond to compare against the best candidate in the candidate collection.
  #
  # +bond_collection+ - A BondCollection that contains a candidate for comparison.
  #
  # ==== Examples
  #
  #   SpreadCalculator.to_benchmark(Bond.new, BondCollection.new) #=> { bond: 'C1', benchmark: 'G1', spread_to_benchmark: 0.0122 }
  def self.to_benchmark(bond, bond_collection)
    _candidates = candidates(bond, bond_collection)
    candidate = closest_candidate(bond, _candidates)

    { bond: bond.bond, benchmark: candidate.bond, spread_to_benchmark: bond.yield - candidate.yield }
  end

  # Used to calculate the spread_to_curve between a bond and a collection of candidate bonds.
  # 
  # ==== Attributes
  #
  # +bond+ - A Bond to compare against the best candidate in the candidate collection.
  # 
  # +bond_collection+ - A BondCollection that contains a candidate for comparison.
  #
  # ==== Examples
  #
  #   SpreadCalculator.to_curve(Bond.new, BondCollection.new) #=> { bond: 'C1', spread_to_curve: 0.0122 }
  def self.to_curve(bond, bond_collection)
    _candidates = candidates(bond, bond_collection)
    candidate = pseudo_candidate(bond.term, *_candidates)

    { bond: bond.bond, spread_to_curve: bond.yield - candidate.yield }
  end

private

  def self.candidates(bond, bond_collection)
    benchmark_collection = bond_collection.add(bond)
    upper_lower_candidates(bond, benchmark_collection)
  end

  def self.upper_lower_candidates(bond, benchmark_collection)
    bond_index = benchmark_collection.index(bond)
    [benchmark_collection[bond_index - 1], benchmark_collection[bond_index + 1]]
  end

  def self.closest_candidate(bond, candidates)
    lower_candidate = (bond.term - candidates[0].term).abs
    upper_candidate = (bond.term - candidates[1].term).abs

    lower_candidate < upper_candidate ? candidates[0] : candidates[1]
  end

  def self.pseudo_candidate(term, lower_candidate, upper_candidate)
    point1 = { x: lower_candidate.term, y: lower_candidate.yield }
    point2 = { x: upper_candidate.term, y: upper_candidate.yield }

    _yield = LinearInterpolator.calculate(term, point1, point2)

    Bond.new({ term: term, yield: _yield })
  end
end
