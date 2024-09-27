require 'json'

class MoviesFilter
  def input_filters
    ARGV
  end
  
  def movies
    file = File.read('./movies.json') 
    @movies = JSON.parse(file)
  end
  
  def print_by_filter
    movies.each do | movie |
      isFiltered = filter_movie?(movie)
    
      p movie["Title"] if isFiltered
    end    
  end

  def filter_movie?(movie)
    input_filters.all? do | filter_param |
      split_param = filter_param.split('=')
      
      return true if split_param.length < 2
  
      key = split_param[0]
      value = split_param[1]
  
      movie.has_key?(key) && movie[key].include?(value)
    end
  end
end


MoviesFilter.new.print_by_filter