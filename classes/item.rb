require 'date'
class Item
  attr_accessor :id, :genre, :author, :label, :publish_date

  def initialize(params = {})
    @id = params[:id] || Random.rand(1..1000)
    @genre = params[:genre]
    @author = params[:author]
    @label = params[:label]
    @publish_date = (Date.parse(params[:publish_date]) if params[:publish_date])
    @archived = false
  end

  def move_to_archive
    return unless can_be_archived?

    @archived = true
  end

  def add_label=(label)
    @label = label
    label.items.push(self) unless label.items.include?(self)
  end

  def add_author=(author)
    @author = author
    author.items.push(self) unless author.items.include?(self)
  end

  def add_genre=(genre)
    @genre = genre
    genre.items.push(self) unless genre.items.include?(self)
  end

  private

  attr_reader :archived

  def can_be_archived?
    current_year = Time.now.year

    current_year - @publish_date.year > 10
  end
end
