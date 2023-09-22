class Author
  attr_accessor :first_name, :last_name
  attr_reader :items

  def initialize(first_name, last_name)
    @id = Random.rand(1..1000)
    @first_name = first_name
    @last_name = last_name
    @items = []
  end

  def add_item(item)
    item.is_a?(item)
    item.author = self
    @items << item
  end

  def to_hash
    {
      first_name: @first_name,
      last_name: @last_name
    }
  end
end
