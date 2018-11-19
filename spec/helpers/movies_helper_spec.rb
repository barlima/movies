require 'rails_helper'

describe MoviesHelper, type: :helper do
  let(:data) do
    [
      OpenStruct.new({
        id: "6", 
        type: "movie", 
        attributes: OpenStruct.new({
          title: "Godfather",
          plot: "Godfather description", 
          rating: 9.2, 
          poster: "/godfather.jpg"
        })
      })
    ]
  end

  let(:godfather) do
    create(:movie, title: "Godfather")
  end

  let(:other_movie) do
    create(:movie)
  end

  before do
    def other_movie.cover 
      "/random_poster.jpg"
    end
  end

  describe "#movie_rating" do
    it "returns correct rating if movie exists" do
      expect(helper.movie_rating(godfather, data)).to eql(9.2)
    end

    it "returns nil if movie does not exists" do
      expect(helper.movie_rating(other_movie, data)).to be_nil
    end
  end

  describe "#movie_description" do 
    it "returns description if a movie exists" do 
      expect(helper.movie_description(godfather, data)).to eql("Godfather description")
    end

    it "returns nil if movie does not exists" do
      expect(helper.movie_description(other_movie, data)).to be_nil
    end
  end

  describe "#movie_poster" do 
    it "returns poster if a movie exists" do 
      expect(helper.movie_poster(godfather, data)).to include("/godfather.jpg")
    end

    it "returns random movie.cover if movie does not exists" do
      expect(helper.movie_poster(other_movie, data)).to be_a(String)
    end
  end
end