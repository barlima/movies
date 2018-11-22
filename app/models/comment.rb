class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates :body, presence: true
  validate :single_comment

  private

  def single_comment
    if movie.comments.find_by(user_id: user.id)
      errors.add(:user, "has already commented this movie")
    end
  end
end
