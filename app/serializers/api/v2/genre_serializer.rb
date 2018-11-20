class Api::V2::GenreSerializer < ActiveModel::Serializer
  attributes :id, :name, :movies_number
  def movies_number
    object.movies.size
  end
end
