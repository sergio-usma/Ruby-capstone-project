class Genre
  attr_accessor :name
  attr_reader :items

  def initialize(name)
    @name = name
    @items = []
  end

  def add_item(item)
    item.genre = self
    @items << item
  end

  def to_s
    "Name: #{@name}"
  end

  def to_hash
    {
      name: @name,
      items: @items.map(&:to_s)
    }
  end
end
