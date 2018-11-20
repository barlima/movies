class Api::V1::MoviesController < Api::ApiController
  skip_before_action :check_auth, only: %i(index)

  def index
    @movies = Movie.all
    render json: @movies, each_serializer: Api::V1::MovieSerializer, 
      serializer: ActiveModel::Serializer::CollectionSerializer
  end

  def show
    @movie = Movie.find(params[:id])
    render json: @movie
  end
end