class SingleCombat
  def combat(combatant1, combatant2)
    return if combatant1.nil? || combatant2.nil?
    if(Random.rand >= 0.5)
      combatant1.attack(combatant2)
      combatant2.attack(combatant1) unless combatant2.dead?
    else
      combatant2.attack(combatant1)
      combatant1.attack(combatant2) unless combatant1.dead?
    end
    
    combatant1.save
    combatant2.save
  end
end