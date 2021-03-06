require './combat_controller'

controller = CombatController.new
controller.add_hillsfar_platoon("Ssthil", Defend.new)
controller.add_hillsfar_platoon("Skale", Defend.new)
controller.add_hillsfar_platoon("Smith", Defend.new)
controller.add_hillsfar_platoon("Jolwoon", Defend.new)
controller.add_hillsfar_platoon("Blin", Defend.new)
controller.add_hillsfar_platoon("Cooper", Defend.new)
controller.add_hillsfar_platoon("Ellalil", Defend.new)
controller.add_hillsfar_platoon("Drun", Defend.new)
controller.add_warforged_platoon("Borgo", Defend.new)
controller.add_warforged_platoon("Monshoonson", Defend.new)
controller.add_warforged_platoon("Goethite", Defend.new)
controller.add_warforged_platoon("Star", Daze.new)
controller.add_warforged_platoon("Bjarn", Defend.new)
controller.add_warforged_platoon("Blooddrop", Surge.new)
controller.add_warforged_platoon("Nethrem", SneakAttack.new)
controller.add_warforged_platoon("Dink", Defend.new)
controller.match_up_armies

puts controller.to_s