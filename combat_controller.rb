require_relative 'platoon'
require_relative 'hillsfarther'
require_relative 'warforged'


class CombatController
  attr_accessor :hillsfar_army, :warforged_army
  
  def initialize
    @hillsfar_army = []
    @warforged_army = []
  end
  
  def add_hillsfar_platoon(commander_name)
    @hillsfar_army << Platoon.new(Hillsfarther, commander_name)
  end
  
  def add_warforged_platoon(commander_name)
    @warforged_army << Platoon.new(Warforged, commander_name)
  end
  
  def combat
    @warforged_army[0].attack(@hillsfar_army[0])
    @hillsfar_army[0].attack(@warforged_army[0])
    to_s
  end
  
  def to_s
    puts "Warforged"
    puts @warforged_army[0].to_s
    puts "Hillsfar"
    puts @hillsfar_army[0].to_s
  end
  
end

#require './combat_controller'
controller = CombatController.new
controller.add_hillsfar_platoon("alice")
controller.add_warforged_platoon("bob")

puts controller.to_s