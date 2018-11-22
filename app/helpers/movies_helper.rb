module MoviesHelper
  def movie_rating(movie, data)
    get_attribute(movie, data, :rating)
  end

  def movie_description(movie, data)
    get_attribute(movie, data, :plot)
  end

  def movie_poster(movie, data)
    poster_url = get_attribute(movie, data, :poster)
    if poster_url
      MovieData::POSTER_ENDPOINT + poster_url.sub('/','')
    else
      movie.cover
    end
  end

  private 

  def get_attribute(movie, data, param)
    if data.is_a?(Array)
      film = data.find{ |m| m.attributes.title == movie.title } rescue nil
    elsif data
      film = data
    end
    film.attributes.send(param) if film
  end
end