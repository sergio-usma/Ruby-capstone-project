require_relative '../classes/author'
require_relative '../classes/genre'
require_relative '../classes/source'
require_relative '../classes/label'
require_relative '../classes/game'

describe Game do
  let(:author) { Author.new('Ari', 'Gibson') }
  let(:genre) { Genre.new('Indie') }
  let(:source) { Source.new('Ludum Dare') }
  let(:label) { Label.new('Hollow Knight', 'Black') }
  let(:game_data) do 
    {
      author: author,
      genre: genre,
      label: label,
      source: source,
      publish_date: Date.parse('27-02-2017'),
      last_played_at: '17-03-2020',
      multiplayer: true
    }
  end

  let(:game) do 
    Game.new(
      game_data[:author],
      game_data[:genre],
      game_data[:source],
      game_data[:label],
      game_data[:publish_date],
      game_data[:last_played_at],
      game_data[:multiplayer],
    )
  end

  describe '#initialize' do
    it 'creates a new Game object' do
      expect(game).to be_a(Game)
    end

    it 'correctly sets the label' do
      expect(game.label).to eq(game_data[:label])
    end

    it 'correctly sets the author' do
      expect(game.author).to eq(game_data[:author])
    end

    it 'correctly sets the source' do
      expect(game.source).to eq(game_data[:source])
    end

    it 'correctly sets the genre' do
      expect(game.genre).to eq(game_data[:genre])
    end

    it 'correctly sets the publish_date' do
      expect(game.publish_date).to eq(game_data[:publish_date])
    end

    it 'correctly sets the multiplayer attribute' do
      expect(game.multiplayer).to eq(game_data[:multiplayer])
    end
  end
end