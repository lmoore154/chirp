class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :username, :email, :following, :followable
  has_many :posts

  def following
    object.followees(User)
  end

  def followable
    object.followers(User)
  end

end
