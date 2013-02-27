class Leonard
  attr_accessor :facts, :rules

  def initialize
    @facts = []
    @rules = []
  end
end

l = Leonard.new

p l.facts
p l.rules
