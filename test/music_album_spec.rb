require_relative '../classes/music_album'
require_relative '../classes/genre'
require 'date'

describe MusicAlbum do
  let(:genre) { Genre.new('Rock') }
  let(:album_data) do
    {
      title: 'Sample Album',
      author: 'Sample Artist',
      genre: genre,
      source: 'CD',
      label: 'Sample Label',
      publish_date: Date.parse('01-01-2020'),
      on_spotify: true
    }
  end

  let(:album) do
    MusicAlbum.new(
      album_data[:title],
      album_data[:author],
      album_data[:genre],
      album_data[:source],
      album_data[:label],
      album_data[:publish_date],
      album_data[:on_spotify]
    )
  end


  describe '#initialize' do
    it 'creates a new MusicAlbum object' do
      expect(album).to be_a(MusicAlbum)
    end

    it 'correctly sets the title' do
      expect(album.title).to eq(album_data[:title])
    end

    it 'correctly sets the author' do
      expect(album.author).to eq(album_data[:author])
    end

    it 'correctly sets the genre' do
      expect(album.genre).to eq(album_data[:genre])
    end

    it 'correctly sets the source' do
      expect(album.source).to eq(album_data[:source])
    end

    it 'correctly sets the label' do
      expect(album.label).to eq(album_data[:label])
    end

    it 'correctly sets the publish_date' do
      expect(album.publish_date).to eq(album_data[:publish_date])
    end

    it 'correctly sets the on_spotify attribute' do
      expect(album.on_spotify).to eq(album_data[:on_spotify])
    end
  end

  describe '#can_be_archive?' do
    it 'returns true if the album can be archived' do
      album.publish_date = Date.parse('01-01-2010')
      expect(album.can_be_archive?).to be(true)
    end

    it 'returns false if the album cannot be archived' do
      album.publish_date = Date.parse('01-01-2022')
      expect(album.can_be_archive?).to be(false)
    end
  end
end
