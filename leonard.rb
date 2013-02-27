class Leonard
  attr_accessor :facts, :rules

  def initialize
    @facts = []
    @rules = []
  end

  def add_fact(fact)
    @facts << fact
  end

  def add_rule(conditions, result)
    @rules << [conditions, result]
  end
end

l = Leonard.new

l.add_fact 'no_child'
l.add_fact 'children'
%w(low average high).each do |amount|
  %w(rent path wage).each do |type|
    l.add_fact "#{amount}_#{type}"
  end
end

l.add_rule ['no_child'], 'discount_children_0'
l.add_rule ['children'], 'discount_children_100'
l.add_rule ['low_wage'], 'discount_rent_200'
l.add_rule ['average_wage'], 'discount_rent_100'
l.add_rule ['high_wage'], 'discount_rent_0'

p l.facts
p l.rules
