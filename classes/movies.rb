require_relative '../classes/item'

class Movies < Item
  attr_reader :archived
  attr_accessor :silent

  def initialize(args)
    super(args[:genre], args[:author], args[:source], args[:label], args[:publish_date])
    @silent = args[:silent]
  end

  def can_be_archived?
    super && @silent == true
  end
end
