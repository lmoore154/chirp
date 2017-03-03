class UserExpandedSerializer < ActiveModel::Serializer
  attributes :id, :username, :first_name, :last_name, :email, :photo_url, :token
end
