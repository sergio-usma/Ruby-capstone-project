require_relative 'item'
class Books < Item
  attr_accessor :publisher, :cover_state

  def initialize(params = {})
    super(params)
    @cover_state = params[:cover_state]
    @publisher = params[:publisher]
  end

  private

  def can_be_archived?
    super || @cover_state == 'bad'
  end
end
