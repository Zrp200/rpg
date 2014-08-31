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

		@objects.each { |obj| @object_locations[obj.location] = obj.name.to_sym }
	end

	def run_game

		until @stop
			self.prompt_user
			self.update_locations
			print @map.draw(10, 10, @object_locations)
		end
	end

	def update_locations
		@object_locations.clear
		@objects.each { |obj| @object_locations[obj.location] = obj.name.to_sym }
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

farmhouse = build_farmhouse
george = Player.new("George")
world_map = Map.new(farmhouse)
game = Game.new(george, world_map)
game.run_game