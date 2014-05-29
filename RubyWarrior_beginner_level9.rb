
class Player
	
  def initialize
  	@health = 20
  	@wall_touched = "No"
  end
  
  def play_turn(warrior)
   actions(warrior)
  	record_health(warrior)
  end
   
  def actions(warrior)
    if warrior.feel.wall?
      warrior.pivot!
  	 #if the warrior has not yet touched the back wall of the level...
  	 elsif @wall_touched == "No"
  	   #if the square behind is empty, walk backwards
  	 	if warrior.feel(:backward).empty?
  	 		warrior.walk! :backward
  	 	#if there's a captive, rescue them
  	 	elsif warrior.feel(:backward).captive?
  	 		warrior.rescue! :backward
  	 	elsif warrior.feel(:backward).enemy?
  	 		warrior.attack! :backward
  	 	#if the warrior touches the back wall, set the wall_touched variable to yes
  	 	else warrior.feel(:backward).wall?
  	 		@wall_touched = "Yes"
  	 	end
	 else	
    	#if the square in front is empty...
    	if warrior.feel.empty?
    	  #If taking damage and low on health, walk backward until no longer taking damage
    	  if taking_damage?(warrior)
    	  	if warrior.health < 12
    	  		warrior.walk! (:backward)
      	else
      		warrior.walk!
      	end
        #If low on health and not taking damage, rest
        elsif !taking_damage?(warrior) and warrior.health < 20
        	warrior.rest!
        elsif should_warrior_shoot?(warrior)
      	warrior.shoot!
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
    end 
  end
  
  def taking_damage?(warrior)
    warrior.health < @health
  end
  
  def look_around(warrior)
  	@line_of_sight = warrior.look
  end
  
  def should_warrior_shoot? (warrior)
  	line_of_sight = warrior.look
  	distance_to_enemy = line_of_sight.index { |space| space.enemy? == true} || 4
  	distance_to_captive = line_of_sight.index { |space| space.captive? == true } || 4
  	distance_to_enemy < distance_to_captive
  end
  
  def record_health(warrior)
    @health = warrior.health
  end
  
end 
    

  