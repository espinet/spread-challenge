require 'csv'
Dir["./lib/*.rb"].each {|file| require file }

records = []

# Import record from CSV
CSV.foreach(ARGV[0], headers: true) do |row|
  records << Formatter.parse(row.to_hash)
end

# Calculate spreads for challenge 1 and 2
bonds = BondCollection.new(records)
corporate_bonds = bonds.filter(type: 'corporate')
government_bonds = bonds.filter(type: 'government')

spread_to_benchmark = []
spread_to_curve = []

corporate_bonds.each do |bond|
  spread_to_benchmark << SpreadCalculator.to_benchmark(bond, government_bonds)
  spread_to_curve << SpreadCalculator.to_curve(bond, government_bonds)
end

# Export results from calculations to csv files
if spread_to_benchmark.any?
  CSV.open('spread_to_benchmark.csv', 'w') do |csv|
    csv << spread_to_benchmark[0].keys

    spread_to_benchmark.each do |spread|
      csv << Formatter.prettify(spread).values
    end
  end
end

if spread_to_curve.any?
  CSV.open('spread_to_curve.csv', 'w') do |csv|
    csv << spread_to_curve[0].keys

    spread_to_curve.each do |spread|
      csv << Formatter.prettify(spread).values
    end
  end
end
