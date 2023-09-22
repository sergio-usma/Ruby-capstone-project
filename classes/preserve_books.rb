class PreserveBooks
  def gets_books
    return [] unless File.exist?('./data/books.json')

    books = []
    file = File.read('./data/books.json')
    return [] if file.empty?

    data_hashes = JSON.parse(file)
    data_hashes.each do |book|
      books << Books.from_hash(book)
    end
    books
  end

  def save_books(books)
    return if books.empty?

    data_hashes = books.map(&:to_hash)
    File.write('./data/books.json', JSON.pretty_generate(data_hashes))
  end
end
