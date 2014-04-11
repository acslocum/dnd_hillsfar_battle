class SneakAttack
  def apply(attacker,defender)
    attacker.bonus_to_damage = 6
  end
  
  def end(attacker,defender)
    attacker.bonus_to_damage = 0
  end
end