require 'json'
require_relative '../classes/author'

class PreserveAuthors
  def authors
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

    file_path = './data/authors.json'
    existing_authors = []

    if File.exist?(file_path)
      file_contents = File.read(file_path)
      existing_data = JSON.parse(file_contents)
      existing_authors = existing_data['authors'] if existing_data['authors'].is_a?(Array)
    end

    combined_authors = existing_authors + authors.map(&:to_hash)
    authors_data = { authors: combined_authors }

    File.open(file_path, 'w') do |output_file|
      output_file.puts(JSON.generate(authors_data))
    end
  end
end
