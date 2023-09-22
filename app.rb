require 'fileutils'
require 'json'
require_relative 'classes/author'
require_relative 'classes/books'
require_relative 'classes/game'
require_relative 'classes/genre'
require_relative 'classes/item'
require_relative 'classes/label'
require_relative 'classes/movies'
require_relative 'classes/music_album'
require_relative 'classes/preserve_books'
require_relative 'classes/preserve_movies'
require_relative 'classes/preserve_sources'
require_relative 'classes/source'

# rubocop:disable all
class App
  attr_accessor :books, :item, :labels, :games, :authors

  def initialize
    FileUtils.mkdir_p('./data')
    @books = PreserveBooks.new.gets_books
    @labels = []
    @music_albums = []
    @genres = []
    @movies = []
    @preserve_movies = PreserveMovies.new
    @sources = []
    @preserve_sources = PreserveSources.new
    @games = []
    @authors = []
    load_data
  end

  def load_data
    load_music_albums
    load_genres
    load_movies
    load_sources
    load_games
    load_books
  end

  def save_data
    save_music_albums
    save_genres
    save_games
    save_books
  end

  def load_games
    return unless File.exist?('./data/games.json')

    json_data = File.read('./data/games.json')
    return if json_data.empty?

    games_data_array = JSON.parse(json_data)

    if games_data_array.is_a?(Array) && games_data_array.all? { |game_data| game_data.is_a?(Hash) }
      @games = games_data_array.map do |game|
        Game.new({
          title: game['title'],
          author: game['author'],
          source: game['source'],
          label: game['label'],
          multiplayer: game['multiplayer'],
          last_played_at: game['last_played_at'],
          publish_date: game['publish_date']
          }
        )
      end
    else
      puts 'Invalid JSON data format in the file'
    end
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

  def load_books
    @books = PreserveBooks.new.gets_books || []
  end

  def save_books
    PreserveBooks.new.save_books(@books)
  end

  def save_games
    File.write('./data/games.json', JSON.pretty_generate(@games.map(&:to_hash)))
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

  def load_authors
    return unless File.exist?('./data/authors.json')

    json_data = File.read('./data/authors.json')
    return if json_data.empty?

    @authors = JSON.parse(json_data).map do |author_data|
      author = Author.new(author_data['first_name'], author_data['last_name'])

      author_data['items'].each do |item_data|
        item = Item.new({
          title: item_data['title'],
          author: author,
          genre: item_data['genre']
        })
      end
    end
  end

  def save_genres
    File.write('./data/genres.json', JSON.pretty_generate(@genres.map(&:to_hash)))
  end

  def save_authors
    File.write('./data/authors.json', JSON.pretty_generate(@authors.map(&:to_hash)))
  end

  def run
    puts ['Welcome to the Library', '']
    menu_prompt
    input = gets.chomp.to_i
    menu_nav(input)
    go_back unless input == 13
  end

  def load_movies
    @movies = PreserveMovies.new.gets_movies || []
  end

  def load_sources
    @sources = PreserveSources.new.gets_sources || []
  end

  def menu_prompt
    puts [
      '1 - List all books', '2 - List all music albums', '3 - List all movies', '4 - List of games',
      '5 - List all genres', '6 - List all labels', '7 - List all authors', '8 - List all sources',
      '9 - Add a book', '10 - Add a music album', '11 -  Add a movie', '12 - Add a game', '13  - Exit'
    ]
  end

  def menu_nav(input)
    case input
    when 1 then puts list_all_books
    when 2 then puts list_all_music_albums
    when 3 then puts list_all_movies
    when 4 then puts list_all_games
    when 5 then puts list_all_genres
    when 6 then puts list_all_labels
    when 7 then puts list_all_authors
    when 8 then puts list_all_sources
    when 9 then puts add_book
    when 10 then puts add_music_album
    when 11 then puts add_a_movie
    when 12 then puts add_game
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
    puts 'Enter publish date in format yyyy-mm-dd'
    publish_date = gets.chomp
    book = Books.new(title: title, author: author, genre: genre, publisher: publisher, cover_state: cover_state,
                     publish_date: publish_date)
    @books << book
    puts 'Book added successfully'
    save_books
  end

  def add_game
    puts 'Enter title'
    title = gets.chomp
    puts 'Enter first author\'s name'
    first_author_name = gets.chomp
    puts 'Enter second author\'s name'
    last_author_name = gets.chomp
    puts 'Enter genre'
    genre_name = gets.chomp
    puts 'Enter source'
    source = gets.chomp
    puts 'Enter label'
    label = gets.chomp
    puts 'Enter publish date in format yyyy-mm-dd'
    publish_date = gets.chomp
    puts 'Is the game multiplayer? (true/false)'
    multiplayer = gets.chomp.downcase == 'true'
    puts 'Last time played? (yyyy-mm-dd)'
    last_played_at = gets.chomp

    genre = @genres.find { |g| g.name == genre_name }
    unless genre
      genre = Genre.new(genre_name)
      @genres << genre
      puts "New genre created: #{genre.name}"
    end

    author = @authors.find { |a| a.first_author_name == first_author_name }
    unless genre
      author = Author.new(first_author_name, last_author_name)
      @authors << author
      puts "New genre created: #{genre.name}"
    end

    game_params = {
      title: title,
      first_author_name: first_author_name,
      last_author_name: last_author_name,
      genre: genre,
      author: author,
      source: source,
      label: label,
      publish_date: publish_date,
      multiplayer: multiplayer,
      last_played_at: last_played_at
    }

    game = Game.new(game_params)
    @games << game
    puts 'Game created successfully'
    save_data
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
    puts 'Enter publish date in format yyyy-mm-dd'
    publish_date = gets.chomp
    puts 'Is the album on Spotify? (Y/N)'
    user_input = gets.chomp.downcase

    on_spotify = case user_input
    when 'yes', 'y'
      true
      when 'no', 'n'
      false
      else
      puts "Invalid input for Spotify status. Assuming 'No'"
      false
      end
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
      puts 'No booksfound'
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

  def add_a_movie
    puts 'Enter movie title:'
    title = gets.chomp
    puts 'Enter movie genre:'
    genre_name = gets.chomp
    puts 'Enter movie author:'
    author_name = gets.chomp
    puts 'Enter movie source:'
    source_name = gets.chomp
    puts 'Enter movie label:'
    label = gets.chomp
    puts 'Enter movie publish date in format yyyy-mm-dd:'
    publish_date = gets.chomp
    puts 'Is the movie silent? (Y/N):'
    silent_input = gets.chomp.downcase

    silent = case silent_input
             when 'y'
               true
             when 'n'
               false
             else
               puts "Invalid input for silent. Assuming 'N'."
               false
             end

    genre = Genre.new(genre_name)


    first_name, last_name = author_name.split

    author = Author.new(first_name, last_name)

    source = Source.new(source_name)

    unless @sources.include?(source)
      @sources << source
      @preserve_sources.save_sources(@sources)
    end

    movie_args = {
      title: title,
      genre: genre,
      author: author,
      source: Source.new(source_name),
      label: label,
      publish_date: publish_date,
      silent: silent
    }

    new_movie = Movies.new(movie_args)
    @movies << new_movie

    @preserve_movies.save_movies(@movies)

    puts 'Movie added successfully!'
  end

  def list_all_movies
    if @movies.empty?
      puts "\nSorry, you haven't added any movies yet"
    else
      puts "\nMovies:"
      puts '-' * 80
      puts "%-5s %-30s %-20s %-15s %-15s %-10s" % ["Index", "Title", "Director", "Genre", "Release Date", "Silent"]
      puts '-' * 80
  
      # Iterate through the movies and display them, but only if there are movies to display.
      @movies.each_with_index do |movie, index|
        title = movie.label.respond_to?(:title) ? movie.label.title : "Unknown"
        artist = "#{movie.author.first_name} #{movie.author.last_name}"
        genre = movie.genre.respond_to?(:genre_name) ? movie.genre.genre_name : "Unknown"
        release_date = movie.publish_date.nil? ? 'Unknown' : movie.publish_date.to_s
        silent = movie.silent ? 'Yes' : 'No'
  
        puts "%-5d %-30s %-20s %-15s %-15s %-10s" % [index + 1, title, artist, genre, release_date, silent]
      end
    end
  end
  

  def list_all_sources
    if @sources.empty?
      puts "\nSorry, you haven't added any sources yet"
    else
      puts "\nSources:"
      puts '-' * 80
      puts "%-5s %-30s" % ["Index", "Source Name"]
      puts '-' * 80

      @sources.each_with_index do |source, index|
        puts "%-5d %-30s" % [index + 1, source.source_name]
      end
    end
  end

  def list_all_games
    game_counter = 1
    if @games.empty?
      puts 'No games found'
    else
      @games.each do |game|
        puts "#{game_counter}
        Title: \"#{game.title}\",
        Multiplayer: #{game.multiplayer},
        Publish Date: #{game.publish_date}"
        game_counter += 1
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

  def list_all_authors
    if @authors.empty?
      puts 'No authors found'
    else
      formatted_authors = @authors.each_with_index.map do |author, index|
        "#{index + 1}. Name: #{author.first_author_name} #{author.last_author_name}"
      end
      puts formatted_authors.join("\n")
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
# rubocop:enable all