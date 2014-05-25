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
    #if the square in front is not empty, you will always want to attack
    else
      warrior.attack!
    end
    @health = warrior.health
  end
end 