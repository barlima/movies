require "rails_helper"

describe "Comments requests", type: :request do
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

  let!(:other_user) do
    User.create(
      email: "test2@example.com",
      name: "test2",
      confirmed_at: Time.zone.now,
      password: "password"
    )
  end

  describe "top comments" do
    before do
      Comment.create(body: "First comment", user_id: user.id, movie_id: 1)
      Comment.create(body: "Second comment", user_id: user.id, movie_id: 2, created_at: 11.days.ago)
      Comment.create(body: "Third comment", user_id: user.id, movie_id: 3)
      Comment.create(body: "Other user comment", user_id: other_user.id, movie_id: 4)
    end

    it "should return only comments from last week" do
      visit "/top_commenters"
      expect(page).to have_selector("table tr", count: 3)
    end
  end
end
