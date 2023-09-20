require_relative '../classes/item'
require_relative '../classes/genre'
require_relative '../classes/music_album'

require 'date'

describe MusicAlbum do
  let(:publish_date) { Date.parse('2010-01-01') }

  let(:album_data) do
    {
      title: 'Sample Album',
      author: 'Sample Artist',
      genre: 'Rock',
      source: 'CD',
      label: "test",
      publish_date: publish_date.to_s,
      on_spotify: true
    }
  end

  let(:album) { MusicAlbum.new(album_data) }

  describe '#initialize' do
    it 'creates a new MusicAlbum object' do
      expect(album).to be_a(MusicAlbum)
    end

    it 'correctly sets the title' do
      expect(album.title).to eq(album_data[:title])
    end

    it 'correctly sets the on_spotify attribute' do
      expect(album.on_spotify).to eq(album_data[:on_spotify])
    end
  end

  describe '#can_be_archived?' do
    it 'returns true if the album can be archived' do
      album.publish_date = Date.parse('01-01-2010')
      expect(album.can_be_archived?).to be(true)
    end

    it 'returns false if the album cannot be archived' do
      album.on_spotify = false
      expect(album.can_be_archived?).to be(false)
    end
  end

  describe '#to_s' do
    it 'returns a string representation of the album' do
      expected_string = "Title: Sample Album, Artist: Sample Artist, Genre: Rock, Source: CD, Label: test, Publish Date: #{publish_date}, On Spotify: Yes"
      expect(album.to_s).to eq(expected_string)
    end
  end

  describe '#to_hash' do
    it 'returns a hash representation of the album' do
      expected_hash = {
        title: 'Sample Album',
        author: 'Sample Artist',
        genre: "Rock",
        source: 'CD',
        label: "test",
        publish_date: publish_date,
        on_spotify: true
      }
      expect(album.to_hash).to eq(expected_hash)
    end
  end
end
