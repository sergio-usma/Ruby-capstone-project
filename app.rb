require_relative 'classes/books'
require_relative 'classes/item'
require_relative 'classes/label'
require_relative 'classes/genre'
require_relative 'classes/music_album'
require 'json'
require 'fileutils'

class App
  attr_accessor :books, :item, :labels

  def initialize
    FileUtils.mkdir_p('./data')
    @books = []
    @labels = []
    @music_albums = []
    @genres = []
    load_data
  end

  def load_data
    load_music_albums
    load_genres
  end

  def save_data
    save_music_albums
    save_genres
  end

  def load_music_albums
    return unless File.exist?('./data/music_albums.json')

    json_data = File.read('./data/music_albums.json')
    return if json_data.empty?

    album_data_array = JSON.parse(json_data)

    # Ensure album_data_array is an array of hashes
    if album_data_array.is_a?(Array) && album_data_array.all? { |album_data| album_data.is_a?(Hash) }
      @music_albums = album_data_array.map do |album_data|
        MusicAlbum.new(
          title: album_data['title'],
          author: album_data['author'],
          genre: album_data['genre'],
          source: album_data['source'],
          label: album_data['label'],
          publish_date: album_data['publish_date'],
          on_spotify: album_data['on_spotify']
        )
      end
    else
      puts 'Invalid JSON data format in the file.'
    end
  end

  def save_music_albums
    File.write('./data/music_albums.json', JSON.pretty_generate(@music_albums.map(&:to_hash)))
  end

  def load_genres
    return unless File.exist?('./data/genres.json')

    json_data = File.read('./data/genres.json')
    return if json_data.empty?

    @genres = JSON.parse(json_data).map do |genre_data|
      genre = Genre.new(genre_data['name'])

      genre_data['items'].each do |item_data|
        item = Item.new(
          title: item_data['title'],
          author: item_data['author'],
          genre: genre
        )

        genre.add_item(item)
      end

      genre
    end
  end

  def save_genres
    File.write('./data/genres.json', JSON.pretty_generate(@genres.map(&:to_hash)))
  end

  def run
    puts ['Welcome to the Library', '']
    menu_prompt
    input = gets.chomp.to_i
    menu_nav(input)
    go_back unless input == 13
  end

  def menu_prompt
    puts [
      '1 - List all books', '2 - List all music albums', '3 - List all movies', '4 - List of games',
      '5 - List all genres', '6 - List all labels', '7 - List all authors', '8 - List all sources',
      '9 - Add a book', '10 - Add a music album', '11 -  Add a movie', '12 - Add a game', '13  - Exit'
    ]
  end

  # rubocop:disable Metrics/CyclomaticComplexity
  def menu_nav(input)
    case input
    when 1 then puts list_all_books
    when 2 then puts list_all_music_albums
    when 3 then puts 'List all movies'
    when 4 then puts 'List all games'
    when 5 then puts list_all_genres
    when 6 then puts list_all_labels
    when 7 then puts 'List all authors'
    when 8 then puts 'List all sources'
    when 9 then puts add_book
    when 10 then puts add_music_album
    when 11 then puts 'Add a movie'
    when 12 then puts 'Add a game'
    when 13 then exit
    else
      puts 'Invalid input'
    end
  end
  # rubocop:enable Metrics/CyclomaticComplexity

  def go_back
    puts ['Press Enter to return to the menu', '']
    gets.chomp
    run
  end

  def add_book
    puts 'Enter title'
    title = gets.chomp
    puts 'Enter author'
    author = gets.chomp
    puts 'Enter genre'
    genre = gets.chomp
    puts 'Enter publisher'
    publisher = gets.chomp
    puts 'Enter cover state'
    cover_state = gets.chomp
    puts 'Enter publish date in format dd-mm-yyyy'
    publish_date = gets.chomp
    book = Books.new(title: title, author: author, genre: genre, publisher: publisher, cover_state: cover_state,
                     publish_date: publish_date)
    @books << book
    puts 'Book added successfully'
  end

  def add_music_album
    puts 'Enter title'
    title = gets.chomp
    puts 'Enter author'
    author = gets.chomp
    puts 'Enter genre'
    genre_name = gets.chomp
    puts 'Enter source'
    source = gets.chomp
    puts 'Enter label'
    label = gets.chomp
    puts 'Enter publish date in format dd-mm-yyyy'
    publish_date = gets.chomp
    puts 'Is the album on Spotify? (true/false)'
    on_spotify = gets.chomp.downcase == 'true'

    # Check if the genre already exists or create a new one
    genre = @genres.find { |g| g.name == genre_name }
    unless genre
      genre = Genre.new(genre_name)
      @genres << genre
      puts "New genre created: #{genre.name}"
    end

    music_album_params = {
      title: title,
      author: author,
      genre: genre,
      source: source,
      label: label,
      publish_date: publish_date,
      on_spotify: on_spotify
    }
    music_album = MusicAlbum.new(music_album_params)
    @music_albums << music_album
    genre.add_item(music_album)
    puts 'Music album added successfully'
    save_data
  end

  def list_all_books
    book_counter = 1
    if @books.empty?
      puts 'No books found'
    else
      @books.each do |book|
        puts "#{book_counter}.
        Publisher: \"#{book.publisher}\",
        Cover state: #{book.cover_state} ,
        Publish date: #{book.publish_date}"
        book_counter += 1
      end; nil
    end
  end

  def list_all_music_albums
    if @music_albums.empty?
      puts 'No music albums found'
    else
      formatted_albums = @music_albums.each_with_index.map do |album, index|
        "#{index + 1}. #{album}"
      end

      puts formatted_albums.join("\n")
    end
  end

  def list_all_genres
    if @genres.empty?
      puts 'No genres found'
    else
      formatted_genres = @genres.each_with_index.map do |genre, index|
        "#{index + 1}. Name: #{genre.name}"
      end
      puts formatted_genres.join("\n")
    end
  end

  def list_all_labels
    if @labels.empty?
      puts 'No labels found'
    else
      @labels.each do |label|
        puts "Title: #{label.title}, Color: #{label.color}"
      end
    end
  end
end
