require_relative 'classes/books'
require_relative 'classes/item'
require_relative 'classes/label'

class App
  attr_accessor :books, :item, :labels

  def initialize
    @books = []
    @labels = []
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

  def menu_nav(input)
    case input
    when 1 then puts 'List all books' && list_all_books
    when 2 then puts 'List all music albums'
    when 3 then puts 'List all movies'
    when 4 then puts 'List all games'
    when 5 then puts 'List all genres'
    when 6 then puts 'List all labels'
    when 7 then puts 'List all authors'
    when 8 then puts 'List all sources'
    when 9 then puts 'Add a book' && add_book
    when 10 then puts 'Add a music album'
    when 11 then puts 'Add a movie'
    when 12 then puts 'Add a game'
    when 13 then puts 'Exit' && exit
    else
      puts 'Invalid input'
    end
  end

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
end
