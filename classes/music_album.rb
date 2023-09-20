require_relative 'item'

class MusicAlbum < Item
  attr_accessor :title, :on_spotify

  def initialize(params = {})
    super(params)
    @title = params[:title]
    @on_spotify = params[:on_spotify] || false
  end

  def can_be_archived?
    super && @on_spotify
  end

  def to_s
    "Title: #{@title}, Artist: #{@author}, Genre: #{@genre}, Source: #{@source}, Label: #{@label}, Publish Date: #{@publish_date}, On Spotify: #{@on_spotify ? 'Yes' : 'No'}"
  end

  def to_hash
    {
      title: @title,
      author: @author,
      genre: @genre,
      source: @source,
      label: @label,
      publish_date: @publish_date,
      on_spotify: @on_spotify
    }
  end
end
