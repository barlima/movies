require 'uri'
require 'net/http'

class MovieData
  API_ENPOINT = "https://pairguru-api.herokuapp.com/api/v1/movies/"
  POSTER_ENDPOINT = "https://pairguru-api.herokuapp.com/"

  def call(movie)
    title = URI.encode(movie.title)
    url = URI.parse(API_ENPOINT + title)
    begin
      response = Net::HTTP.get(url)
      format_response(response)
    rescue Timeout::Error
      false
    end
  end

  def collection(movies)
    data = []
    threads = []

    movies.each do |movie|
      threads << Thread.new do
        title = URI.encode(movie.title)
        url = URI.parse(API_ENPOINT + title)

        begin
          response = Net::HTTP.get(url)
          data << format_response(response)
        rescue Timeout::Error
          false
        end
      end
    end

    threads.each{|t| t.join}
    data
  end

  private 

  def format_response(response)
    res = JSON.parse(response, object_class:OpenStruct)
    res.data
  end
end