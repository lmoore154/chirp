class UserListSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :username, :email, :photo_url, :followers_count, :followees_count

  has_many :following
  has_many :followable

  def following
    object.followees(User)
  end

  def followable
    object.followers(User)
  end

  class UserSerializer < ActiveModel::Serializer
    attributes :id, :username, :email
  end

end
