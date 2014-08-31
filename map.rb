require_relative "map_utility.rb"

class Map

	attr_reader :map_hash

  def initialize(map_hash)
  	@map_hash = map_hash
  end

  def draw(x_lim, y_lim, object_locations)
		snapshot = ""
		x_lim.times do |y|
			y_lim.times do |x|
			  snapshot += MAP_ELS[object_locations[[x, y]]]
			end
			snapshot += "\n"
		end
		snapshot
	end

	# def draw_objects(x_lim, y_lim, snapshot, object_locations)
	# 	x_lim.times do |y|
	# 		y_lim.times do |x|
	# 			snapshot += MAP_ELS[object_locations[[x, y]]] if object_locations[[x, y]]
	# 		end
	# 	end
	# 	snapshot
	# end

end