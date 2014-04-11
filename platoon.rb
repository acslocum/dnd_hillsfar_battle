require_relative 'commander'

class Platoon
  attr_accessor :units
  
  def initialize(klass, commander_name, special_attack)
    @commander = Commander.new(commander_name, special_attack)
    @units = []
    60.times do
      @units << klass.new
    end
    @last_count = 60
    @used_special_attack = false
    @special_attack_round=false
  end
  
  def attack(enemy_platoon)
    special_attack = @commander.special_attack if @special_attack_round
    @crits=0
    #only gang up by 2 on 1
    max_attacks = self.size
    max_attacks = 2*enemy_platoon.size if(2*enemy_platoon.size < self.size)
    @units.each_with_index { |unit, index|
      @crits+=enemy_platoon.single_combat(unit,index,special_attack)
      break if index > max_attacks
    }
    special_attack_done if @special_attack_round
  end
  
  def combatant(index)
    return nil if @units.size==0
    @units[index % @units.size]
  end
  
  def single_combat(enemy, index, special_attack)
    return 0 if @units.size == 0
    defender = @units[index % @units.size]
    apply_special_attack(enemy, defender)
    crit = enemy.attack(defender)
    remove_special_attack(enemy,defender)
    @units.delete(defender) if defender.dead?
    return crit
  end
  
  def apply_special_attack(attacker, defender)
    return unless @special_attack_round
    @commander.special_attack.apply(attacker,defender)
  end
  
  def remove_special_attack(attacker, defender)
    return unless @special_attack_round
    @commander.special_attack.end(attacker,defender)
  end
  
  def health
    return 0.0 if @units.size == 0
    @units.map(&:health_percent).reduce(:+) / 60
  end
  
  def bloodied_count
    @units.count(&:bloodied?)
  end
  
  def size
    @units.size
  end
  
  def deaths
    count = @last_count
    @last_count = size
    count - size
  end
  
  def dazed
    @units.count{ |unit| unit.dazed?}
  end
  
  def use_special_attack
    @special_attack_round = true unless @used_special_attack
  end
  
  def special_attack_done
    @special_attack_round = false
    @used_special_attack = true
  end
  
  def to_s
    "#{@commander.name}: #{@units.count} units, #{bloodied_count} bloodied, #{'%2.1f' % (health * 100)}% health, #{deaths} deaths, #{dazed} dazed #{'DEFEATED' if @units.count==0}"
  end
end