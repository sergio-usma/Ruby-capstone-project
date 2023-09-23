require 'json'
require_relative '../classes/author'

class PreserveAuthors
  def gets_authors
    return [] unless File.exist?('./data/authors.json')

    authors = []
    file = File.read('./data/authors.json')
    return [] if file.empty?

    authors_data = JSON.parse(file)
    authors_data['authors'].each do |author|
      authors << Author.new(author.first_name, author.last_name)
    end
    authors
  end

  def save_authors(authors)
    return if authors.empty?

    authors_data = { authors: authors.map(&:author_name) }
    File.open('./data/authors.json', 'w') do |file|
      file.puts(JSON.generate(authors_data))
    end
  end
end