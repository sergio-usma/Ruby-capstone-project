require_relative '../item'

class MusicAlbum < Item
  attr_accessor :title, :on_spotify

  def initialize(title, author, genre, source, label, publish_date, on_spotify = false)
    super(genre, author, source, label, publish_date)

    @title = title
    @on_spotify = on_spotify
  end

  def can_be_archived?
    super && @on_spotify
  end  

  def to_s
    "Title: #{@title}, Artist: #{@author}"
  end 

  def to_hash
    {
      title: @title,
      author: @author,
      genre: @genre.name,
      source: @source,
      label: @label,
      publish_date: @publish_date,
      on_spotify: @on_spotify
    }
  end
  
end
