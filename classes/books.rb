require_relative 'item'
class Books < Item
  attr_accessor :publisher, :cover_state

  def initialize(params = {})
    super(params)
    @cover_state = params[:cover_state]
    @publisher = params[:publisher]
  end

  def to_hash
    {
      title: @title,
      author: @author,
      genre: @genre,
      publish_date: @publish_date,
      cover_state: @cover_state,
      publisher: @publisher
    }
  end

  def self.from_hash(hash)
    new(
      genre: Genre.new(hash['genre']['genre_name']),
      author: Author.new(hash['author']['first_name'], hash['author']['last_name']),
      publish_date: hash['publish_date'],
      cover_state: hash['cover_state'],
      publisher: hash['publisher']
    )
  end

  private

  def can_be_archived?
    super || @cover_state == 'bad'
  end
end
