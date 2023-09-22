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
      title: 'Hollow Knight',
      author: author,
      genre: genre,
      label: label,
      source: source,
      publish_date: '2017-02-20',
      last_played_at: '2017-03-20',
      multiplayer: true
    }
  end

  let(:game) do
    Game.new(game_data)
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

    it 'correctly sets the genre' do
      expect(game.genre).to eq(game_data[:genre])
    end

    it 'correctly sets the publish_date' do
      expect(game.publish_date).to eq((Date.strptime(game_data[:publish_date], '%Y-%m-%d') if game_data[:publish_date]))
    end

    it 'correctly sets the multiplayer attribute' do
      expect(game.multiplayer).to eq(game_data[:multiplayer])
    end
  end

  describe '#can_be_archived?' do
    it 'return true if parent\'s method returns true OR if last_played_at is greater than 2' do
      expect(game.can_be_archived?).to be(true)
    end
  end
end
