class Combatant
  attr_accessor :hp,:bonus_to_hit, :bonus_to_damage, :bonus_to_ac

  def initialize(hp, to_hit, ac)
    @hp = hp
    @hp_max = hp
    @ac = ac
    @to_hit = to_hit
    @bonus_to_hit = 0
    @bonus_to_damage = 0
    @bonus_to_ac=0
    @dazed = false
  end
  
  def attack(combatant)
    roll = to_hit_roll
    combatant.hit_by(roll,damage_roll,is_crit?(roll), crit, is_flub?(roll))
    #puts "crit!" if is_crit?(roll)
    #puts "flub!" if is_flub?(roll)
    return 1 if is_crit?(roll)
    return 0
  end
  
  def hit_by(hit_roll, damage_roll, is_crit, crit_damage, is_flub)
    return if is_flub
    if(is_crit)
      @hp -= crit_damage
    else
      @hp -= (damage_roll+@bonus_to_damage) if hit_roll >= (@ac+@bonus_to_ac)
    end
    @hp=0 if @hp<0
  end
  
  def to_hit_roll
    Random.rand(1..20)+@to_hit+@bonus_to_hit
  end
  
  def is_crit?(roll)
    (roll-@to_hit)==20
  end
  
  def is_flub?(roll)
    (roll-@to_hit)==1
  end

  def dead?
    @hp <= 0
  end
  
  def health_percent
    @hp.to_f / @hp_max
  end
  
  def bloodied?
    @hp*2 <= @hp_max
  end
  
  def healing_surge
    surge_value = @hp_max/4
    @hp += surge_value
    @hp=@hp_max if @hp>@hp_max
  end
  
  def daze
    @dazed=true
    @bonus_to_hit=-4
  end
  
  def undaze
    @bonus_to_hit=0 if dazed?
    @dazed = false
  end
  
  def dazed?
    @dazed
  end
  
  def save
    undaze if Random.rand(1..20) >= 10
  end
  
end