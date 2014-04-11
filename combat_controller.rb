require_relative 'platoon'
require_relative 'hillsfarther'
require_relative 'warforged'
require_relative 'daze'
require_relative 'defend'
require_relative 'sneak_attack'
require_relative 'surge'
require_relative 'single_combat'


class CombatController
  attr_accessor :hillsfar_army, :warforged_army, :matchups
  
  def initialize
    @hillsfar_army = {}
    @warforged_army = {}
    @matchups = []
  end
  
  def add_hillsfar_platoon(commander_name, special_attack)
    @hillsfar_army[commander_name] = Platoon.new(Hillsfarther, commander_name, special_attack)
  end
  
  def add_warforged_platoon(commander_name, special_attack)
    @warforged_army[commander_name] = Platoon.new(Warforged, commander_name, special_attack)
  end
  
  def match_up_armies
    @matchups = @hillsfar_army.keys.shuffle.zip @warforged_army.keys
  end
  
  def combat
    @matchups.each do |match|
      hillsfar = @hillsfar_army[match[0]]
      warforged = @warforged_army[match[1]]
      max = [hillsfar.size,warforged.size].max
      combat_pairs = (1..max).to_a
      combat_pairs = combat_pairs.zip(warforged.units,hillsfar.units)
      combat_pairs.each_with_index do |pair, index| 
        break if index > max_attacks(hillsfar,warforged)
        warforger = pair[1]
        hillsfarther = pair[2]
        warforger = warforged.combatant(index) if warforger.nil?
        hillsfarther = hillsfar.combatant(index) if hillsfarther.nil?
        break if hillsfarther.nil? || warforger.nil?
        warforged.apply_special_attack(warforger, hillsfarther)
        SingleCombat.new.combat(warforger,hillsfarther)
        warforged.remove_special_attack(warforger,hillsfarther)
        warforged.units.delete(warforger) if warforger.dead?
        hillsfar.units.delete(hillsfarther) if hillsfarther.dead?
      end
      print(warforged,hillsfar)
    end
    return
  end
  
  def use_special_attack(name)
    @warforged_army[name].use_special_attack
  end
  
  def end_special_attack(name)
    @warforged_army[name].special_attack_done
  end
  
  def max_attacks(hillsfar,warforged)
    2*[hillsfar.units.size,warforged.units.size].min
  end
  
  def print(warforged,hillsfar)
    puts warforged.to_s
    puts hillsfar.to_s
    puts
  end
  
  def to_s
    puts @warforged_army.values.map(&:to_s)
    puts @hillsfar_army.values.map(&:to_s)
    return
  end
end

