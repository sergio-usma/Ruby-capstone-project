require_relative 'item'
require 'date'

class Game < Item
  attr_accessor :title, :multiplayer, :last_played_at

  def initialize(params = {})
    super(params)
    @title = params[:title]
    @multiplayer = params[:multiplayer]
    @last_played_at = (Date.strptime(params[:last_played_at], '%d-%m-%Y') if params[:last_played_at])
  end

  def can_be_archived?
    current_year = Time.now.year

    super ? true : current_year - last_played_at.year > 2 ? true : false
  end
end
