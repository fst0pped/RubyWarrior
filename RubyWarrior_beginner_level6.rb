
class Player
	
  def play_turn(warrior)
    if @health == nil
      @health = warrior.health
    end
    #declaring the "@wall_touched" variable without overwriting any existing "Yes" value
    if @wall_touched != "Yes"
    	@wall_touched = "No"
    end
   actions(warrior)
  	record_health(warrior)
  end
   
  def actions(warrior)
  	 #if the warrior has not yet touched the back wall of the level...
  	 if @wall_touched == "No"
  	   #if the square behind is empty, walk backwards
  	 	if warrior.feel(:backward).empty?
  	 		warrior.walk! :backward
  	 	#if there's a captive, rescue them
  	 	elsif warrior.feel(:backward).captive?
  	 		warrior.rescue! :backward
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
        elsif taking_damage?(warrior) == FALSE and warrior.health < 20
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
    end 
  end
  
  def taking_damage?(warrior)
    @taking_damage = warrior.health < @health
  end
  
  def record_health(warrior)
    @health = warrior.health
  end
  
end 
    

  