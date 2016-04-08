require_relative "../../util/utility.rb"

class Player

  attr_accessor :location, :inventory
  attr_reader :name

  def initialize(name, game)
    @game = game
    @location = [0, 0]
    @name = "player"
    @inventory = { gold: 0, silver: 0, copper: 0, items: [] }

    @game.player = self
    @game.objects[:player] = self
    @game.object_locations[@location] = :player
  end

  def move(dir)
    directions = { north: [0, -1], south: [0, 1], east: [1, 0], west: [-1, 0] }
    return false if dir == nil || !directions[dir.downcase.to_sym]
    @location = sum_arr(@location, directions[dir.downcase.to_sym])
  end

  def inventory
    puts "You are carrying..."
    @inventory.each { |key, value| puts "#{key}: #{value}" }
  end

  def open(target=nil)
    if target == nil
      puts "Can't open nothing."
      return
    end

    if nearby?(target)
      target.open(self)
    else
      puts "There's nothing to open."
    end
  end

  def drop(item=nil)
    if item == nil
      puts "Can't drop nothing."
      return
    end

    if @inventory[:items].include?(item.name)
      empty_spot = nearby_locs(@location).find { |loc| @game.object_locations[loc] == :empty }
      if empty_spot
        @game.object_locations[empty_spot] = item.name.to_sym
        item.location = empty_spot
        @inventory[:items].delete(item.name)
      else
        puts "You can't drop anything here."
      end
    else
      puts "You aren't carrying #{item.name}"
    end
  end

  def pick(item)
    self.pick_up(item)
  end

  def pick_up(item=nil)

    if item == nil
      puts "Can't pick up nothing."
      return
    end

    if !@inventory[:items].include?(item.name)
      if nearby?(item)
        @inventory[:items] << item.name
        @game.object_locations[item.location] = :empty
        item.location = nil
      else
        puts "There's nothing to pick up."
      end
    else
      puts "You're already carrying #{item.name}."
    end
  end


  def i
    self.inventory
  end

  def attack
    puts "You attack!"
  end

  def nearby?(target)
    nearby_locations = nearby_locs(@location)
    nearby_locations.include?(target.location)
  end

  def check_nearby
    objs = ""
    nearby_locations = nearby_locs(@location)
    nearby_locations.each do |loc|
      if @game.object_locations[loc] != :empty && @game.object_locations[loc] != nil
        objs += "#{@game.object_locations[loc].to_s}, "
      end
    end

    objs.length > 0 ? objs : "nothing"
  end

  def look
    puts "You can see #{self.check_nearby}."
  end

end