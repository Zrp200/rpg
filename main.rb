require_relative "user_class.rb"
require_relative "map_utility.rb"
require_relative "map.rb"

class Game

	def initialize(player, map)
		@player = player
		@stop = false
		@map = map
		@objects = [@player]
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
		@objects.each do |obj|
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
			if @player.respond_to?(verb)
				@player.method(verb).call(noun)
			else
				puts "You don't know how to do that."
			end
		end
	end
end

map_hash = build_farmhouse
george = Player.new("George")
world_map = Map.new(map_hash)
game = Game.new(george, world_map)
game.run_game