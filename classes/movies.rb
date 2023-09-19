class Movies
  attr_reader :archived
  attr_accessor :silent

  def initialize(args)
    super(args[:genre], args[:author], args[:source], args[:label], args[:publish_date])
    @silent = args[:silent]
  end
end
