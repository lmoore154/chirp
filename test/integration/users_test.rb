require 'test_helper'

class UsersTest < ActionDispatch::IntegrationTest

  test 'users#follow' do
    user1 = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)
    post "/follow/#{user2.id}",
    params: { token: user1.token }
    assert response.ok?
    assert user1.follows?(user2)
  end

  # test 'users#unfollow' do
  #
  # end

end
