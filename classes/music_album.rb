class MusicAlbum < Item
  attr_accessor :title, :artist, :on_spotify

  def initialize(title, artist, genre, source, label, publish_date, on_spotify = false)
    super(genre, artist, source, label, publish_date)

    @title = title
    @on_spotify = on_spotify
  end

  def can_be_archived?
    super && @on_spotify
  end
end
