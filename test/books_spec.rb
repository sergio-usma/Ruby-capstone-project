require_relative '../classes/books'

describe Book do
  let(:publisher) { 'Test' }
  let(:cover_state) { 'Acceptable' }
  let(:publish_date) { '18/09/2023' }
  let(:book) { Book.new(publisher, cover_state, publish_date) }

  describe '#initialize' do
    it 'Adds the publisher, cover_state, and publish_date attributes' do
      expect(book.publisher).to eq(publisher)
      expect(book.cover_state).to eq(cover_state)
      expect(book.publish_date).to eq(Date.parse(publish_date))
    end

    it 'inherits archived: false from its parent' do
      expect(book.archived).to be(false)
    end
  end

  describe '#can_be_archived?' do
    it 'return true if parent\'s method returns true OR if cover_state equals to bad' do
      book.cover_state = 'bad'
      expect(book.can_be_archived?).to be(true)
    end

    it 'returns false when the cover state is not bad' do
      book.cover_state = 'good'
      expect(book.can_be_archived?).to be(false)
    end
  end
end
