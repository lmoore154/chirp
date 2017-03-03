class UserProfileSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :photo_url
  has_many :posts
end
