class Movies < Item
  attr_reader :archived
  attr_accessor :silent

  def initialize(args = {})
    super(args)
    @source = args[:source]
    @silent = args[:silent]
  end

  def can_be_archived?
    super && @silent == true
  end

  def to_s
    ""
  end

  def to_hash
    {
      'genre' => {
        'genre_name' => @genre.name
      },
      'author' => {
        'first_name' => @author.first_name,
        'last_name' => @author.last_name
      },
      'source' => {
        'source_name' => @source.source_name
      },
      'label' => {
        'title' => @label.respond_to?(:title) ? @label.title : @label.to_s,
        'color' => @label.respond_to?(:color) ? @label.color : nil
      },
      'publish_date' => @publish_date,
      'silent' => @silent
    }
  end

  def self.from_hash(hash)
    new(
      genre: Genre.new(hash['genre']['genre_name']),
      author: Author.new(hash['author']['first_name'], hash['author']['last_name']),
      source: Source.new(hash['source']['source_name']),
      label: Label.new(hash['label']['title'], hash['label']['color']),
      publish_date: hash['publish_date'],
      silent: hash['silent']
    )
  end
end
