class Player
  
  	def initialize
  		@health = 20
		@directions = [:forward, :backward, :left, :right]
  	end
  
	def play_turn(warrior)
		stair_direction(warrior)
		actions(warrior)
		record_health(warrior)
	end
	
	def actions(warrior)
		if rest?(warrior)
			warrior.rest!
		elsif surrounded?(warrior)
			contain_enemies(warrior) #warrior.bind!
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
	
	def local_enemies(warrior)
		@directions.each do |direction|
			if warrior.feel(direction).enemy?
				@enemy_direction << direction
			end
		end
	end
	
	def surrounded?(warrior)
		@enemies = 0
		@directions.each { |direction| warrior.feel(direction).enemy?; @enemies += 1 }
		@enemies > 1			
	end
	
	def contain_enemies(warrior)
		@directions.each do |direction|
			if warrior.feel(direction).enemy?
				@enemy_direction = direction
			end
		end
		warrior.bind!(@enemy_direction)
	end
	
	def record_health(warrior)
		@health = warrior.health
	end
  
end
  