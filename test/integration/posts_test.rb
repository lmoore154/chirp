require 'test_helper'

class PostsTest < ActionDispatch::IntegrationTest

  test 'posts#show' do
    post = FactoryGirl.create(:post)
    get "/posts/#{post.id}"
    assert response.ok?
    json = JSON.parse(response.body)
    assert_equal post.body, json["body"]
  end

  test 'posts#timeline' do
    post1 = FactoryGirl.create(:post)
    user1 = post1.user
    post2 = FactoryGirl.create(:post)
    user2 = post2.user
    user1.follow!(user2)

    get "/timeline",
    params: { token: user1.token }
    assert response.ok?
    json = JSON.parse(response.body)
    assert_equal post1.body, json.last["body"]  # timeline orders newest to oldest
    assert_equal post2.body, json.first["body"]
    assert_equal user1.username, json.last["user"]["username"]
    assert_equal user2.username, json.first["user"]["username"]
  end

  test 'posts#timeline authentication' do
    get '/timeline'
    refute response.ok?
    json = JSON.parse(response.body)
    assert_equal "You must be logged in to do that.", json.first
  end

  test 'posts#create' do
    user = FactoryGirl.create(:user)
    post '/posts',
    params: { body: "This is a post", token: user.token }
    assert response.ok?
    json = JSON.parse(response.body)
    assert_equal "This is a post", json["body"]
  end

  test 'posts#create authentication' do
    post '/posts',
    params: { body: "Post post" }
    refute response.ok?
    json = JSON.parse(response.body)
    assert_equal "You must be logged in to do that.", json.first
  end


end
