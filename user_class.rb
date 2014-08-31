require_relative "utility.rb"

class Player

	attr_reader :location, :name

	def initialize(name)
		@location = [0, 0]
		@name = "player"
		@inventory = { gold: 0, silver: 0, copper: 0, items: [] }
	end

	def move(dir)
		directions = { north: [0, 1], south: [0, -1], east: [1, 0], west: [-1, 0] }
		return false if !directions[dir.downcase.to_sym]
		@location = sum_arr(@location, directions[dir.downcase.to_sym])
		puts @location
	end

	def inventory
		puts "You are carrying..."
		@inventory.each { |key, value| puts "#{key}: #{value}" }
	end

	def i
		self.inventory
	end

	def go(dir)
		self.move(dir)
	end

end