require_relative "utility.rb"

class NPC

	def initialize
		@alive = true
		@inventory = { gold: 0, silver: 0, copper: 0, items: [] }
	end

	def move
	end

	def attack
	end

	def speak
	end

end