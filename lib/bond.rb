class Bond
  include Comparable

  attr_accessor :bond, :type, :term, :yield

  def initialize(attributes)
    @bond =  attributes['bond'] || attributes[:bond]
    @type =  attributes['type'] || attributes[:type]
    @term =  attributes['term'] || attributes[:term]
    @yield = attributes['yield'] || attributes[:yield]
  end

  # Used to sort Bonds in a BondCollection by term.
  def <=>(other)
    self.term <=> other.term
  end
end
