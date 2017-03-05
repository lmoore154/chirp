class Post < ApplicationRecord
  belongs_to :user

  validates :body, presence: true, length: { minimum: 1, maximum: 140 }

  def self.timeline(user)
    following_ids = user.followees(User).pluck(:id)
    all_ids = following_ids << user.id
    Post.where(user_id: all_ids).order("created_at DESC")
  end

end
