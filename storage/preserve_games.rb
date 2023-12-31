require 'json'

class PreserveGames
  def gets_games
    return [] unless File.exist?('./data/games.json')

    saved_games = []
    file = File.read('./data/games.json')
    return [] if file.empty?

    data_hashes = JSON.parse(file)
    data_hashes.each do |game|
      saved_games << Game.from_hash(game)
    end
    saved_games
  end

  def save_games(games)
    return if games.empty?

    data_hashes = games.map(&:to_hash)
    File.write('./data/games.json', JSON.pretty_generate(data_hashes))
  end
end
