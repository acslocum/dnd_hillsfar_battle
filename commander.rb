
class Commander
  attr_accessor :name
  
  def initialize(name)
    @name = name
  end
  
  def attack_bonus
    1
  end
  
  def damage_bonus
    3
  end
  
  def feint_attack_bonus
    2
  end
end