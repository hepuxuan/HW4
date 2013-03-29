class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 R)
  end
  def Movie.find_movie_by_director movie
    movie=Movie.find(movie)
    if (!movie.director)||(movie.director.length<1)
      return "#{movie.title} has no director"
    else
      Movie.where(:director=>(movie.director))
    end
  end
end
