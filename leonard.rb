module Leonard
  class Fact
    attr_accessor :name

    def initialize(name)
      @name = name
    end
  end

  class Rule
    attr_accessor :conditions, :result

    def initialize(conditions, result)
      @conditions = conditions
      @result = result
    end

    def has_fact?(fact)
      @conditions.include?(fact.class == Leonard::Fact ? fact.name : fact)
    end
  end

  class Engine
    attr_accessor :facts, :rules

    def initialize
      @facts = []
      @rules = []
    end

    def add_fact(fact)
      @facts << Leonard::Fact.new(fact)
    end

    def add_rule(conditions, result)
      @rules << Leonard::Rule.new(conditions, result)
    end

    def checked_rule?(rule)
      rule.conditions.sort == rule.conditions.sort & @facts.map(&:name).sort
    end
  end
end

l = Leonard::Engine.new

# FACTS

l.add_fact 'no_child'
l.add_fact 'children'
%w(low average high).each do |amount|
  %w(rent path wage).each do |type|
    l.add_fact "#{amount}_#{type}"
  end
end

# RULES

l.add_rule ['no_child'], 'discount_children_0'
l.add_rule ['children'], 'discount_children_100'

l.add_rule ['low_path'], 'discount_rent_0'
l.add_rule ['average_path'], 'discount_rent_100'
l.add_rule ['high_path'], 'discount_rent_200'

l.add_rule ['children', 'high_path'], 'discount_path_50'

# Rule#has_fact?

p l.rules.first.has_fact? 'no_child'
p l.rules.first.has_fact? l.facts.first

# Engine#check_rule

p l.checked_rule? l.rules.last

p l.facts
p l.rules
