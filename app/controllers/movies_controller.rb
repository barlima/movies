class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:send_info]

  def index
    @movies = Movie.all.decorate
    @movies_data = MovieData.new.collection(@movies)
  end

  def show
    @movie = Movie.find(params[:id])
    @movie_data = MovieData.new.call(@movie)
    @comment = Comment.new
  end

  def send_info
    if current_user && params[:id]
      EmailWorker.perform_async(current_user.id, params[:id])
      # call_rake("mailer:send_movie_data", { movie_id: params[:id], user_id: current_user.id })
      redirect_back(fallback_location: root_path, notice: "Email sent with movie info.")
    else
      redirect_back(fallback_location: root_path, notice: "Something went wrong. Please retry.")
    end
  end

  def export
    # call_rake("exporter:export_movies_data", { user_id: current_user.id })
    ExportWorker.perform_async(current_user.id)
    redirect_to root_path, notice: "Movies exported"
  end
end
