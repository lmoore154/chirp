class PostSerializer < ActiveModel::Serializer
  attributes :id, :body, :created_at
  has_one :user
  class UserSerializer < ActiveModel::Serializer
    attributes :id, :username
  end

end
