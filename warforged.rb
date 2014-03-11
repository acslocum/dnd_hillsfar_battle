require_relative 'combatant'

class Warforged < Combatant
  #l18 soldier fire giant
  #hp:174
  #ac:34
  #to hit:23 -> 34-23 11+ (45pct)
  #dam 2d12+8 -> 21 : 9.45 avg
  
  def initialize()
    super(174, 23, 34)
  end
  
  def damage_roll
    2.times.collect {Random.rand(1..12)}.inject(:+) + 8
  end
  
  def crit
    2*12+8
  end
  
end