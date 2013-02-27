class Leonard
  attr_accessor :facts, :rules

  def initialize
    @facts = []
    @rules = []
  end

  def add_fact(fact)
    @facts << fact
  end
end

l = Leonard.new

l.add_fact 'enfants'
l.add_fact 'loyer'

p l.facts
p l.rules
