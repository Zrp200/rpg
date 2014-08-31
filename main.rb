require_relative "user_class.rb"
require_relative "map_utility.rb"
require_relative "map.rb"
require_relative "thing_class.rb"

class Game

	attr_accessor :object_locations, :objects, :player

	def initialize(map)
		@player = nil
		@stop = false
		@map = map
		@objects = {}
		@object_locations = {}
		@object_locations.merge!(@map.map_hash)

		self.update_locations
	end

	def run_game

		until @stop
			self.prompt_user
			self.update_locations
			print @map.draw(15, 15, @object_locations)
		end
	end

	def update_locations
		@objects.each do |key, obj|
			current_location = @object_locations.select { |key, value| value == obj.name.to_sym }.keys[0]
			if @object_locations[obj.location] != :empty || @object_locations[obj.location] == nil
				obj.location = current_location
				next
			elsif @object_locations[obj.location] != obj.name.to_sym
				@object_locations[obj.location] = obj.name.to_sym
			  @object_locations[current_location] = :empty
			end
		end
	end

	def prompt_user
		puts "What would you like to do?"
		response = gets.chomp
		system "clear"
		parse_response(response)
	end

	def parse_response(input)
		words = input.split(/ /)
		verb = words[0]
		noun = words[1]

		handle_response(verb, noun)
	end

	def handle_response(verb, noun)

		if verb == nil && noun == nil
			return
		end

		if verb == "quit" || verb == "q"
			@stop = true
			return
		end

		verb = verb.to_sym

		if noun == nil
			if @player.respond_to?(verb)
				@player.method(verb).call
			else
				puts "You don't know how to #{verb.to_s}"
			end
		else
			noun = objects[noun.to_sym]
			if @player.respond_to?(verb)
				@player.method(verb).call(noun)
			else
				puts "You don't know how to do that."
			end
		end
	end
end

map_hash = build_farmhouse
world_map = Map.new(map_hash)
game = Game.new(world_map)
chest = Chest.new("chest", [4, 5], ["sword", "shield"], game)
george = Player.new("George", game)
game.run_game