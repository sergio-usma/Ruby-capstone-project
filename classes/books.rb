require_relative 'item'
class Book < Item
  attr_accessor :publisher, :cover_state

  def initialize(publisher, cover_state, publish_date, archived: false)
    super(publish_date, archived: archived)
    @cover_state = cover_state
    @publisher = publisher
  end

  def can_be_archived?
    archived = super
    archived || @cover_state == 'bad'
  end
end
