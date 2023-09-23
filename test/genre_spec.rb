require_relative '../classes/genre'
require_relative '../classes/music_album'
require 'date'

describe Genre do
  let(:genre_name) { 'Rock' }

  let(:genre) { Genre.new(genre_name) }

  describe '#initialize' do
    it 'creates a new Genre object' do
      expect(genre).to be_a(Genre)
    end

    it 'correctly sets the name' do
      expect(genre.name).to eq(genre_name)
    end
  end

  describe '#add_item' do
    it 'associates an item with the genre' do
      album_data = {
        title: 'Test Album',
        author: 'Test Artist',
        genre: genre,
        source: 'CD',
        label: 'Test Label',
        publish_date: Date.parse('2020-01-01').to_s,
        on_spotify: true
      }
      album = MusicAlbum.new(album_data)

      genre.add_item(album)

      expect(album.genre).to eq(genre)
    end

    it 'adds an item to the genre\'s items collection' do
      album_data = {
        title: 'Test Album',
        author: 'Test Artist',
        genre: genre,
        source: 'CD',
        label: 'Test Label',
        publish_date: Date.parse('2020-01-01').to_s,
        on_spotify: true
      }
      album = MusicAlbum.new(album_data)

      genre.add_item(album)

      expect(genre.items).to include(album)
    end
  end
end
