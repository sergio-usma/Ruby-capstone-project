require_relative '../classes/books'
require 'rspec'

describe Books do
  let(:params) do
    {
      title: 'Sample Book Title',
      author: 'Sample Author',
      genre: 'Fiction',
      publisher: 'Sample Publisher',
      cover_state: 'good',
      publish_date: '2021-09-22'
    }
  end

  subject { described_class.new(params) }

  describe '#initialize' do
    it 'initializes a book with the provided parameters' do
      expect(subject.title).to eq('Sample Book Title')
      expect(subject.author).to eq('Sample Author')
      expect(subject.genre).to eq('Fiction')
      expect(subject.publisher).to eq('Sample Publisher')
      expect(subject.cover_state).to eq('good')
      expect(subject.publish_date).to eq('2021-09-22')
    end
  end

  describe '#to_hash' do
    it 'returns a hash representation of the book' do
      expected_hash = {
        title: 'Sample Book Title',
        author: 'Sample Author',
        genre: 'Fiction',
        publisher: 'Sample Publisher',
        cover_state: 'good',
        publish_date: '2021-09-22'
      }
      expect(subject.to_hash).to eq(expected_hash)
    end
  end
end
