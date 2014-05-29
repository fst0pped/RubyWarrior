class Player
  
  	def initialize
  		@health = 20
  	end
  
	def play_turn(warrior)
		stair_direction(warrior)
		actions(warrior)
		record_health(warrior)
	end
	
	def actions(warrior)
		if rest?(warrior)
			warrior.rest!
		elsif warrior.feel(@stairs).enemy?
			warrior.attack! @stairs
		else
			warrior.walk! @stairs
		end
	end
	
	def stair_direction(warrior)
		@stairs = warrior.direction_of_stairs
	end
	
	def safe?(warrior)
		@health <= warrior.health
	end
	
	def rest?(warrior)
		safe?(warrior) && @health < 15
	end
	
	def record_health(warrior)
		@health = warrior.health
	end
  
end
  