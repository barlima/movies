require 'rails_helper'

RSpec.describe Comment, type: :model do

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

  it "is valid with valid attributes" do
    expect(Comment.new(body: "AAAA", user_id: user.id, movie_id: 1)).to be_valid
  end
  
  it "is not valid without a body" do
    expect(Comment.new(body: nil, user_id: user.id, movie_id: 1)).not_to be_valid
  end

  it "is not valid if a movie is already commented" do
    Comment.create(body: "First comment", user_id: user.id, movie_id: 1)
    expect(Comment.new(body: "Second comment", user_id: user.id, movie_id: 1)).not_to be_valid
  end

  it "is valid if commenting other movie" do
    comment1 = Comment.new(body: "First comment", user_id: 1, movie_id: 1)
    expect(comment1).to be_valid
    comment1.save
    expect(Comment.new(body: "Second comment", user_id: 1, movie_id: 2)).to be_valid
  end
end
