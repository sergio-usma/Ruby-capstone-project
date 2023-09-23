require 'json'
require_relative '../classes/author'

class PreserveAuthors
  def gets_authors
    return [] unless File.exist?('./data/authors.json')

    authors = []
    file = File.read('./data/authors.json')
    return [] if file.empty?

    authors_data = JSON.parse(file)

    if authors_data['authors'].is_a?(Array)
      authors_data['authors'].each do |author_data|
        authors << Author.new(author_data['first_name'], author_data['last_name'])
      end
    else
      puts 'Invalid JSON data format in the file'
    end

    authors
  end

  def save_authors(authors)
    return if authors.empty?

    authors_data = { authors: authors.map { |author| author.to_hash } }
    file_path = './data/authors.json'

    unless File.exist?(file_path)
      File.open(file_path, 'w') {}
    end

    File.open(file_path, 'w') do |file|
      file.puts(JSON.generate(authors_data))
    end
  end
end
