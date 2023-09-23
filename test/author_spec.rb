require_relative '../classes/author'

describe Author do
  let(:author_first_name) { 'Ari' }
  let(:author_last_name) { 'Gibson' }

  let(:author) { Author.new(author_first_name, author_last_name) }

  describe '#initialize' do
    it 'creates a new Author object' do
      expect(author).to be_a(Author)
    end

    it 'correctly sets the name' do
      expect(author.first_name).to eq('Ari')
    end
  end
end
