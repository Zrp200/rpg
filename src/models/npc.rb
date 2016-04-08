require_relative "../../util/utility.rb"

class NPC

  def initialize
    @alive = true
    @inventory = { gold: 0, silver: 0, copper: 0, items: [] }
  end

  def move(dir)
    directions = { north: [0, -1], south: [0, 1], east: [1, 0], west: [-1, 0] }
    return false if dir == nil || !directions[dir.downcase.to_sym]
    @location = sum_arr(@location, directions[dir.downcase.to_sym])
  end

  def attack
  end

  def speak
    phrases = [ "Hello!", "Hi there.", "Greetings." ]
    puts "Hello!"
  end
  
end