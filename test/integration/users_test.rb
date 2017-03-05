require 'test_helper'

class UsersTest < ActionDispatch::IntegrationTest

  test 'users#create' do
    post '/signup',
    params: {
      username: "testuser",
      first_name: "firstname",
      last_name: "lastname",
      email: "user@user.com",
      password: "guest"
    }
    assert response.ok?
    json = JSON.parse(response.body)
    assert_equal json["username"], "testuser"
    assert json["token"]
    refute json["password"]
    refute json["password_digest"]
  end

  test 'users#show' do
    user = FactoryGirl.create(:user)
    get "/users/#{user.id}",
    params: { token: user.token }
    assert response.ok?
    json = JSON.parse(response.body)
    assert_equal user.email, json["email"]
  end

  test 'users can follow and unfollow users while logged in' do
    user1 = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)
    post "/follow/#{user2.id}",
    params: { token: user1.token }
    assert response.ok?
    assert user1.follows?(user2)
    post "/unfollow/#{user2.id}",
    params: { token: user1.token }
    assert response.ok?
    refute user1.follows?(user2)
  end

  test 'users must be logged in to follow and unfollow' do
    post '/follow/2'
    refute response.ok?
    assert_equal response.status, 401
    post '/unfollow/3'
    refute response.ok?
    assert_equal response.status, 401
  end

  test 'user must exist to be followed or unfollowed' do
    user1 = FactoryGirl.create(:user)
    post '/follow/94925595',
    params: { token: user1.token }
    refute response.ok?
    assert_equal response.status, 400
    end

end
