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

    def has_fact?(fact)
      @facts.map(&:name).include?(fact.class == Leonard::Fact ? fact.name : fact)
    end

    def checked_rule?(rule)
      rule.conditions.sort == rule.conditions.sort & @facts.map(&:name).sort
    end

    def search(facts)
      facts.each do |fact|
        self.add_fact fact unless self.has_fact?(fact)
        @rules.each do |rule|
          if rule.has_fact?(fact) && self.checked_rule?(rule) && !@facts.map(&:name).include?(rule.result)
            facts << rule.result
          end
        end
      end
      @facts.last
    end
  end
end

l = Leonard::Engine.new

# FACTS 1

l.add_fact 'low_wage'
l.add_fact 'rent'
l.add_fact 'children'
l.add_fact 'high_path'

# FACTS 2

# l.add_fact 'no_child'
# l.add_fact 'rent'
# l.add_fact 'average_wage'
# l.add_fact 'low_path'

# RULES

l.add_rule ['no_child'], 'discount_children_0'
l.add_rule ['children'], 'discount_children_100'
l.add_rule ['low_wage'], 'discount_rent_200'
l.add_rule ['average_wage'], 'discount_rent_100'
l.add_rule ['high_wage'], 'discount_rent_0'
l.add_rule ['no_rent'], 'discount_rent_0'
l.add_rule ['low_path'], 'discount_path_0'
l.add_rule ['discount_children_0', 'high_path'], 'discount_path_100'
l.add_rule ['discount_rent_0', 'high_path'], 'discount_path_100'
l.add_rule ['discount_children_100', 'discount_rent_100', 'high_path'], 'discount_path_50'
l.add_rule ['discount_children_100', 'discount_rent_200', 'high_path'], 'discount_path_0'
l.add_rule ['discount_children_0', 'discount_rent_0', 'discount_path_0'], 'discount_0'
l.add_rule ['discount_children_100', 'discount_rent_0', 'discount_path_0'], 'discount_100'
l.add_rule ['discount_children_0', 'discount_rent_100', 'discount_path_0'], 'discount_100'
l.add_rule ['discount_children_100', 'discount_rent_100', 'discount_path_0'], 'discount_200'
l.add_rule ['discount_children_0', 'discount_rent_200', 'discount_path_0'], 'discount_200'
l.add_rule ['discount_children_100', 'discount_rent_200', 'discount_path_0'], 'discount_300'
l.add_rule ['discount_children_0', 'discount_rent_0', 'discount_path_50'], 'discount_50'
l.add_rule ['discount_children_100', 'discount_rent_0', 'discount_path_50'], 'discount_150'
l.add_rule ['discount_children_100', 'discount_rent_100', 'discount_path_50'], 'discount_250'
l.add_rule ['discount_children_0', 'discount_rent_200', 'discount_path_50'], 'discount_250'
l.add_rule ['discount_children_100', 'discount_rent_200', 'discount_path_50'], 'discount_350'
l.add_rule ['discount_children_0', 'discount_rent_0', 'discount_path_100'], 'discount_100'
l.add_rule ['discount_children_100', 'discount_rent_0', 'discount_path_100'], 'discount_200'
l.add_rule ['discount_children_0', 'discount_rent_100', 'discount_path_100'], 'discount_200'
l.add_rule ['discount_children_100', 'discount_rent_100', 'discount_path_100'], 'discount_300'
l.add_rule ['discount_children_0', 'discount_rent_200', 'discount_path_100'], 'discount_300'
l.add_rule ['discount_children_100', 'discount_rent_200', 'discount_path_100'], 'discount_400'

# SEARCH

p l.search l.facts.map(&:name)
