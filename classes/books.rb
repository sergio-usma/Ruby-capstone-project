require_relative 'item'
class Books < Item
  attr_accessor :publisher, :cover_state

  def initialize(publisher, cover_state, date)
    super(date)
    @cover_state = cover_state
    @publisher = publisher
  end

  def can_be_archived?
    archived = super
    archived || @cover_state == 'bad'
  end
end
