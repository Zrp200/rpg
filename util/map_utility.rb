MAP_ELS = {
  player: "@",
  corner: "+",
  v_wall: "|",
  h_wall: "-",
  chest: "C",
  empty: " ",
  sword: "!"
}

def build_farmhouse
  farmhouse = {}
  15.times do |x|
    15.times do |y|
      if y.between?(3, 8) && (x == 3 || x == 8)
        farmhouse[[x, y]] = :h_wall
      elsif x.between?(3, 8) && (y == 3 || y == 8)
        if x == 5 && y == 3
          farmhouse[[x, y]] = :empty
        else
          farmhouse[[x, y]] = :v_wall
        end
      else
        farmhouse[[x, y]] = :empty
      end
    end
  end
  farmhouse
end