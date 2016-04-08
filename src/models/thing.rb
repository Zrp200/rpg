require_relative "../../util/utility.rb"

class Thing

  attr_accessor :name, :location

  def initialize(name, location, game)
    @name = name
    @location = location
    @game = game

    @game.objects[name.to_sym] = self
  end

end

class Chest < Thing

  @@chest_count = 0

  def initialize(name, location, contents, game)
    @@chest_count += 1
    @name = name
    @location = location
    @contents = contents
    @locked = false

    @game = game
    @symbol = "chest_#{@@chest_count}".to_sym
    @game.objects[:chest] = self
    @game.object_locations[@location] = :chest
  end

  def open(player)
    if @locked || @contents.empty?
      return false
    end

    message = "You picked up "

    until @contents.empty?
      item = @contents.pop
      message += "#{item.name}, "
      player.inventory[:items] << item.name
    end

    @game.objects.delete(:chest)
    @game.object_locations[@location] = :empty
    puts message
  end

end