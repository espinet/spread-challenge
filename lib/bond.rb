class Bond
  include Comparable

  attr_accessor :bond, :type, :term, :yield

  def initialize(attributes)
    @bond = attributes[:bond]
    @type = attributes[:type]
    @term = attributes[:term]
    @yield = attributes[:yield]
  end

  def <=>(other)
    self.term <=> other.term
  end
end
