class Player
  def play_turn(warrior)
  if @health == nil
    @health = warrior.health
  end
    #if the square in front is empty you have 2 choices - walk or rest
    if warrior.feel.empty?
      if warrior.health >= @health and warrior.health < 20
        warrior.rest!
      else
        warrior.walk!
      end
    #if the square in front is not empty, check whether to rescue or attack
    else
      if warrior.feel.captive?
        warrior.rescue!
      else
        warrior.attack!
      end
    end
    @health = warrior.health
  end
end 