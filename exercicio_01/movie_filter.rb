require 'json'

class MoviesFilter
  def initialize(args, movies)
    @args = args
    @movies = movies
  end
  
  def movies_by_filter
    movies_filtered = @movies.filter do | movie |
      @args.all? do | filter_param |
        filter_by_param(movie, filter_param)  
      end
    end

    movies_filtered.map { | movie | movie["Title"]}
  end

  private

  def filter_by_param(movie, param)
    split_param = param.split('=')

    return true if split_param.length < 2

    key = split_param[0]
    value = split_param[1]
    movie.has_key?(key) && movie[key].include?(value)
  end
end

file = File.read('./movies.json') 
movies = JSON.parse(file)

p MoviesFilter.new(ARGV, movies).movies_by_filter