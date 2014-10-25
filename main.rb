require_relative "user_class.rb"
require_relative "map_utility.rb"
require_relative "map.rb"
require_relative "thing_class.rb"
require_relative "language_parser.rb"
require_relative "key_mapper.rb"

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
			print @map.draw(15, 15, @object_locations)
			self.handle_input
			self.update_locations
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
		print @map.draw(15, 15, @object_locations)
		puts "What would you like to do?"
		response = gets.chomp
		system "clear"
		parse_response(response)
	end

	def handle_input()
		c = read_char
		system "clear"

		case c
		when "\e[A"
			@player.move(:north)
		when "\e[B"
			@player.move(:south)
		when "\e[C"
    	@player.move(:east)
  	when "\e[D"
    	@player.move(:west)
    when "\e[3~"
    	@stop = true
    when "\r"
    	self.prompt_user
    when " "
    	@player.attack
    else
    	puts c.inspect

    	# response += c.to_s
    	# print @map.draw(15, 15, @object_locations)
    	# print "\n#{response}"
    	# t = read_char
    	# handle_input(t, response)
    end
	end

end

map_hash = build_farmhouse
world_map = Map.new(map_hash)
game = Game.new(world_map)
chest = Chest.new("chest", [4, 5], ["sword", "shield"], game)
george = Player.new("George", game)
game.run_game