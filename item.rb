class Item
    attr_accessor :genre, :author, :source, :label, :publish_date
    attr_reader :archived, :id
  
    def initialize(genre, author, source, label, publish_date)
      @genre = genre
      @author = author
      @source = source
      @label = label
      @publish_date = publish_date
      @archived = false
      @id = rand(1..1000)
    end
end  