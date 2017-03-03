class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :username, :email, :following, :followable
  has_many :posts

  private

  def following
    current_user.followees(User)
  end

  def followable
    current_user.followers(User)
  end

end
