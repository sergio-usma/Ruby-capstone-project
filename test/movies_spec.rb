require_relative '../classes/author'
require_relative '../classes/genre'
require_relative '../classes/item'
require_relative '../classes/label'
require_relative '../classes/movies'
require_relative '../classes/source'

describe Movies do
  let(:genre) { Genre.new('Action') }
  let(:author) { Author.new('Lawrence', 'Kioko') }
  let(:source) { Source.new('DVD') }
  let(:label) { Label.new('Movie Title', 'Red') }
  let(:publish_date) { '01-01-2010' }

  subject(:movie) do
    described_class.new(
      genre: genre,
      author: author,
      source: source,
      label: label,
      publish_date: publish_date,
      silent: true
    )
  end

  describe '#can_be_archived?' do
    context 'when the movie can be archived' do
      it 'returns true' do
        expect(movie.can_be_archived?).to be(true)
      end
    end

    context 'when the movie cannot be archived' do
      it 'returns false' do
        movie.silent = false
      end
    end
  end

  describe '#to_hash' do
    it 'returns a hash representation of the movie' do
      expected_hash = {
        'genre' => { 'genre_name' => 'Action' },
        'author' => { 'first_name' => 'Lawrence', 'last_name' => 'Kioko' },
        'source' => { 'source_name' => 'DVD' },
        'label' => { 'title' => 'Movie Title', 'color' => 'Red' },
        'publish_date' => Date.new(2010, 1, 1),
        'silent' => true
      }

      expect(movie.to_hash).to eq(expected_hash)
    end
  end
end
