require_relative "utility.rb"

class Player

	attr_accessor :location, :inventory
	attr_reader :name

	def initialize(name, game)
		@game = game
		@location = [0, 0]
		@name = "player"
		@inventory = { gold: 0, silver: 0, copper: 0, items: [] }

		@game.player = self
		@game.objects[:player] = self
		@game.object_locations[@location] = :player
	end

	def move(dir)
		directions = { north: [0, -1], south: [0, 1], east: [1, 0], west: [-1, 0] }
		return false if dir == nil || !directions[dir.downcase.to_sym]
		@location = sum_arr(@location, directions[dir.downcase.to_sym])
	end

	def inventory
		puts "You are carrying..."
		@inventory.each { |key, value| puts "#{key}: #{value}" }
	end

	def open(target)
		if nearby?(target)
			target.open(self)
		else
			puts "There's nothing to open."
		end
	end

	def i
		self.inventory
	end

	def nearby?(target)
		nearby_locations = nearby_locs(@location)
		nearby_locations.include?(target.location)
	end

	def check_nearby
		objs = ""
		nearby_locations = nearby_locs(@location)
		nearby_locations.each do |loc|
			if @game.object_locations[loc] != :empty && @game.object_locations[loc] != nil
				objs += "#{@game.object_locations[loc].to_s}, "
			end
		end

		objs.length > 0 ? objs : "nothing"
	end

	def look
		puts "You can see #{self.check_nearby}."
	end

end