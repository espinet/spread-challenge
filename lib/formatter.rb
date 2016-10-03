class Formatter
  # Accepts the standard format seen in a bond csv file and converts the columns into datatypes
  # that can be used to calculate spread.
  #
  # ==== Attributes
  #
  # +hash+ - A hash row retrieved from a csv file. The hash must contain the keys 'term' and 'yield'.
  # 'term' is in the format '10.3 years' and yield is in the format '1.22%'. Term is converted from
  # years to days and yield is converted from a decimal percentage.
  #
  # ==== Examples
  #
  #   Formatter.parse({ 'term' => '10.3 years', 'yield' => '1.22%' }) #=> { 'term' => 3759.5, 'yield' => 0.0122 }
  def self.parse(hash)
    hash['term'] = parse_term(hash['term'])
    hash['yield'] = parse_yield(hash['yield'])
    hash
  end

  # Converts the decimal percentage values calculated for spread_to_benchmark or spread_to_curve
  # and converts them to a percentage string '1.22%'.
  #
  # ==== Attributes
  #
  # +hash+ - A hash of symbols with the key :spread_to_benchmark or :spread_to_curve.
  #
  # +key+ - The symbol of the key/value pair you want to convert from a decimal to a percentage string.
  #
  # ==== Examples
  #
  #   Formatter.prettify({ bond: 'C1', spread_to_benchmark: 0.0122 }, :spread_to_benchmark) #=> { bond: 'C2', spread_to_curve: 1.52% }
  #   Formatter.prettify({ bond: 'C2', spread_to_curve: 0.0152 }, :spread_to_curve) #=> { bond: 'C2', spread_to_benchmark: '1.22%' }
  def self.prettify(hash, key)
    hash[key] = prettify_yield(hash[key])
    hash
  end

private

  def self.parse_term(term)
    term.split(' ')[0].to_f * 365
  end

  def self.parse_yield(_yield)
    _yield.gsub('%', '').to_f / 100
  end

  def self.prettify_yield(_yield)
    "#{sprintf('%.2f', _yield * 100)}%"
  end
end


