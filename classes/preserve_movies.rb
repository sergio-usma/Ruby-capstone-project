require 'json'

class PreserveMovies
  def gets_movies
    return [] unless File.exist?('./data/movies.json')

    saved_movies = []
    file = File.read('./data/movies.json')
    return [] if file.empty?

    data_hashes = JSON.parse(file)
    data_hashes.each do |movie|
      saved_movies << Movies.from_hash(movie)
    end
    saved_movies
  end

  def save_movies(movies)
    return if movies.empty?

    data_hashes = movies.map(&:to_hash)
    File.write('./data/movies.json', JSON.pretty_generate(data_hashes))
  end
end
