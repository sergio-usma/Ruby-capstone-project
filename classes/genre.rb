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
end