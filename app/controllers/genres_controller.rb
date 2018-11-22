class GenresController < ApplicationController
  def index
    @genres = Genre.all.decorate
  end

  def movies
    @genre = Genre.find(params[:id]).decorate
    @movies_data = MovieData.new.collection(@genre.movies)
  end
end
