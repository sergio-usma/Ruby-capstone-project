require './item'
require 'date'

class Game < Item
  attr_accessor :multiplayer, :last_played_at

  def initialize(author, genre, source, label, publish_date, last_played_at, multiplayer)
    super(genre, author, source, label, publish_date)
    @multiplayer = multiplayer
    @last_played_at = (Date.strptime(last_played_at, '%d-%m-%Y') if last_played_at)
  end

  def can_be_archived?
    current_year = Time.now.year

    return true if super && current_year - last_played_at.year > 2

    false
  end
end
