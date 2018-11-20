require "rails_helper"

describe "API v2 requests", type: :request do

  describe "GET /api/v2/movies" do
    let!(:genre) do
      create(:genre, name: "Comedy")
    end

    let!(:movies) do 
      10.times do
        create(:movie)
      end

      5.times do
        create(:movie, genre: genre)
      end
    end

    before { get "/api/v2/movies" }

    it "returns HTTP status 200" do
      expect(response).to have_http_status 200
    end

    it "returns all movies" do
      body = JSON.parse(response.body)
      expect(body.size).to eq(15)
    end

    it "returns only id and title" do
      body = JSON.parse(response.body)
      expect(body.first.keys).to match_array(["id", "title", "genre"])
    end

    it "returns genre details" do
      body = JSON.parse(response.body)
      expect(body.first["genre"].keys).to match_array(["id", "name", "movies_number"])
    end

    it "returns movies number from the same genre" do
      body = JSON.parse(response.body)
      expect(body.last["genre"]["movies_number"]).to eql(5)
    end
  end

  describe "GET /api/v2/movies/:id" do
    let!(:movies) do 
      10.times do
        create(:movie)
      end
    end

    let!(:user) do
      User.create(
        email: "test@example.com",
        name: "test",
        confirmed_at: Time.zone.now,
        password: "password"
      )
    end

    before do |example|
      unless example.metadata[:skip_before]
        @env = {}
        @env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials("test@example.com", "password")
        get "/api/v2/movies/1", headers: @env
      end
    end

    it "returns HTTP status 200" do
      expect(response).to have_http_status 200
    end

    it "returns unauthorized if not authenticated", skip_before: true do
      get "/api/v2/movies/1"
      expect(response).to have_http_status 401
    end

    it "returns only id and title" do
      body = JSON.parse(response.body)
      expect(body.keys).to match_array(["id", "title", "genre"])
    end

    it "returns genre details" do
      body = JSON.parse(response.body)
      expect(body["genre"].keys).to match_array(["id", "name", "movies_number"])
    end
  end

end
