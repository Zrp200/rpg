MAP_ELS = {
	player: "@",
	corner: "+",
	h_wall: "|",
	v_wall: "-",
	empty: " "
}

def build_farmhouse
	farmhouse = {}
	10.times do |x|
		10.times do |y|
			if y.between?(3, 8) && (x == 3 || x == 8)
				farmhouse[[x, y]] = :h_wall
			elsif x.between?(3, 8) && (y == 3 || y == 8)
				farmhouse[[x, y]] = :v_wall
			else
				farmhouse[[x, y]] = :empty
			end
		end
	end
	farmhouse
end