require "rails_helper"

describe "API v1 requests", type: :request do

  describe "GET /api/v1/movies" do
    let!(:movies) do 
      10.times do
        create(:movie)
      end
    end

    before { get "/api/v1/movies" }

    it "returns HTTP status 200" do
      expect(response).to have_http_status 200
    end

    it "returns all movies" do
      body = JSON.parse(response.body)
      expect(body.size).to eq(10)
    end

    it "returns only id and title" do
      body = JSON.parse(response.body)
      expect(body.first.keys).to match_array(["id", "title"])
    end
  end

  describe "GET /api/v1/movies/:id" do
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
        get "/api/v1/movies/1", headers: @env
      end
    end

    it "returns HTTP status 200" do
      expect(response).to have_http_status 200
    end

    it "returns unauthorized if not authenticated", skip_before: true do
      get "/api/v1/movies/1"
      expect(response).to have_http_status 401
    end

    it "returns only id and title" do
      body = JSON.parse(response.body)
      expect(body.keys).to match_array(["id", "title"])
    end
  end

end
