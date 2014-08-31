require_relative "map_utility.rb"

class Map

  def initialize(map_hash)
  	@map_hash = map_hash
  end

  def draw(x_lim, y_lim, object_locations)
		snapshot = ""
		x_lim.times do |y|
			y_lim.times do |x|
			  snapshot += MAP_ELS[@map_hash[[x, y]]]
			  snapshot += MAP_ELS[object_locations[[x, y]]] if object_locations[[x, y]]
			end
			snapshot += "\n"
		end
		snapshot
	end

end