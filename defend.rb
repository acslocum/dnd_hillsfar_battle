class Defend
  def apply(attacker,defender)
    attacker.bonus_to_ac = 4
  end
  
  def end(attacker,defender)
    attacker.bonus_to_ac = 0
  end
  
end