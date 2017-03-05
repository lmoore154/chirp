class User < ApplicationRecord
  has_many :posts

  has_secure_password
  has_secure_token

  acts_as_follower
  acts_as_followable

  validates :username, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true
  validates :email, presence: true, uniqueness: true

  def followers
    followers_count
  end

  def followees
    followees_count
  end

end
