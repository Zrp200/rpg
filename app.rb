[
  "./src/models/game.rb",
  "./src/models/user.rb",
  "./util/map_utility.rb",
  "./src/models/map.rb",
  "./src/models/thing.rb",
  "./lib/language_parser.rb",
  "./lib/key_mapper.rb",
].each { |file| require_relative file }

map_hash = build_farmhouse
world_map = Map.new(map_hash)
game = Game.new(world_map)
sword = Thing.new("sword", nil, game)
chest = Chest.new("chest", [4, 5], [sword], game)
george = Player.new("George", game)
game.run_game