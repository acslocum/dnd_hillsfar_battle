require_relative 'combatant'

class Hillsfarther < Combatant
  #Hillfarian - red plume
  #l18 soldier rockfire dreadnaught
  #hp:170
  #ac:34
  #to hit:21 -> 34-21 13 35pct 
  #damage 2d8+18 27 : 9.45
  
  def initialize()
    super(170, 21, 34)
  end
  
  def damage_roll
    2.times.collect {Random.rand(1..8)}.inject(:+) + 18
  end
  
  def crit
    2*8+18
  end
  
end