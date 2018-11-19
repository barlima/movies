require "rails_helper"

describe "Movies requests", type: :request do
  let(:godfather) do
    create(:movie, title: "Godfather")
  end

  let(:pulp_fiction) do
    create(:movie, title: "Pulp Fiction")
  end

  describe "movies list" do
    it "displays right title" do
      visit "/movies"
      expect(page).to have_selector("h1", text: "Movies")
    end
  end

  describe "movies data" do 
    it "returns correct title" do
      response = MovieData.new.call(godfather)
      expect(response.attributes.title).to eql(godfather.title)
    end

    it "returns data form multiple movies" do
      response = MovieData.new.collection([godfather, pulp_fiction])
      expect(response.size).to eql(2)
    end
  end
end
