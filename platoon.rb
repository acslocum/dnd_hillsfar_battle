require_relative 'commander'

class Platoon
  attr_accessor :units
  
  def initialize(klass, commander_name)
    @commander = Commander.new(commander_name)
    @units = []
    60.times do
      @units << klass.new
    end
    @last_count = 60
  end
  
  def attack(enemy_platoon)
    @crits=0
    #only gang up by 2 on 1
    max_attacks = self.size
    max_attacks = 2*enemy_platoon.size if(2*enemy_platoon.size < self.size)
    @units.each_with_index { |unit, index|
      @crits+=enemy_platoon.single_combat(unit,index)
      break if index > max_attacks
    }
  end
  
  def single_combat(enemy, index)
    return 0 if @units.size == 0
    defender = @units[index % @units.size]
    crit = enemy.attack(defender)
    @units.delete(defender) if defender.dead?
    return crit
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
  
  def to_s
    "#{@commander.name}: #{@units.count} units, #{bloodied_count} bloodied, #{'%2.1f' % (health * 100)}% health, #{@crits} crits #{deaths} deaths"
  end
end