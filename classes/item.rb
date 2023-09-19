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

  def can_be_archive?
    current_year = Time.now.year

    return true if current_year - @publish_date.year > 10

    false
  end

  def move_to_archive
    @archived = true if can_be_archive?
  end
end
