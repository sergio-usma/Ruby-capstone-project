require_relative 'item'

class Label
  attr_accessor :title, :color
  attr_reader :item

  def initialize(title, color)
    @id = Random.rand(1..1000)
    @title = title
    @color = color
    @items = []
  end
end
