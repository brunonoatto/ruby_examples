require 'rspec'
require_relative '../movie_filter'

RSpec.describe MoviesFilter do
  let (:args) { ['Genre=Action', 'Year=2009'] }
  let (:movies) do
    [
      {
      "Title" => "Avatar",
      "Year" => "2009",
      "Genre" => "Action",
      },
      {
      "Title" => "I Am Legend",
      "Year" => "2009",
      "Genre" => "Drama, Horror, Sci-Fi",
      },
      {
      "Title" => "300",
      "Year" => "2006",
      "Genre" => "Action, Drama, Fantasy"
      }
    ] 
  end

  context 'empty args' do
    let (:args) { [] }
    let (:klass) { MoviesFilter.new(args, movies) }

    it { expect(klass.movies_by_filter).to match ["Avatar", "I Am Legend", "300"] }
  end
  
  context 'not found movies' do
    let (:args) { ['Genre=Humor'] }
    let (:klass) { MoviesFilter.new(args, movies) }
  
    it { expect(klass.movies_by_filter).to match [] }
  end

  context 'action 2009' do
    let (:klass) { MoviesFilter.new(args, movies) }

    it do
      expect(klass.movies_by_filter).to match ["Avatar"] 
    end
  end

  context 'action 2006' do
    let (:args) { ['Genre=Action', 'Year=2006'] }
    let (:klass) { MoviesFilter.new(args, movies) }

    it { expect(klass.movies_by_filter).to match ["300"] }
  end

  context '2009' do
    let (:args) { ['Year=2009'] }
    let (:klass) { MoviesFilter.new(args, movies) }

    it { expect(klass.movies_by_filter).to match ["Avatar", "I Am Legend"] }
  end
  
  context 'not valid key' do
    let (:args) { ['lala=value', 'Year=2006'] }
    let (:klass) { MoviesFilter.new(args, movies) }

    it { expect(klass.movies_by_filter).to match [] }
  end

  context 'invalidargs ' do
    let (:args) { ['lala', 'Year=2006'] }
    let (:klass) { MoviesFilter.new(args, movies) }

    it { expect(klass.movies_by_filter).to match ["300"] }
  end
end