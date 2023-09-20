require './item'
require 'date'

class Game < Item
  attr_accessor :title, :multiplayer, :last_played_at

  def initialize(params = {})
    super(params)
    @multiplayer = params[:multiplayer]
    @last_played_at = (Date.strptime(params[:last_played_at], '%d-%m-%Y') if params[:last_played_at])
  end

  def can_be_archived?
    current_year = Time.now.year

    return true if super && current_year - last_played_at.year > 2

    false
  end
end
