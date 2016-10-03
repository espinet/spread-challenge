class Formatter
  def self.parse(hash)
    hash['term'] = parse_term(hash['term'])
    hash['yield'] = parse_yield(hash['yield'])
    hash
  end

  def self.prettify(hash)
    hash[:spread_to_benchmark] = prettify_yield(hash[:spread_to_benchmark]) if hash[:spread_to_benchmark]
    hash[:spread_to_curve] = prettify_yield(hash[:spread_to_curve]) if hash[:spread_to_curve]
    hash
  end

private

  def self.parse_term(term)
    term.split(' ')[0].to_f * 365
  end

  def self.parse_yield(_yield)
    _yield.gsub('%', '').to_f / 100
  end

  def self.prettify_term(term)
    years = term / 365
    "#{years} years"
  end

  def self.prettify_yield(_yield)
    "#{sprintf('%.2f', _yield * 100)}%"
  end
end


