require 'test_helper'

class SessionsTest < ActionDispatch::IntegrationTest

  test 'sessions#create' do
    user = FactoryGirl.create(:user)
    post '/login',
    params: { username: user.username, password: user.password }
    assert response.ok?
    json = JSON.parse(response.body)
    assert_equal user.token, json["token"]
  end

  test 'sessions#create authentication' do
    post '/login'
    refute response.ok?
    json = JSON.parse(response.body)
    assert_equal "Incorrect login, try again", json.first
  end

end
