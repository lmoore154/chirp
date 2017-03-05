require 'test_helper'

class UserTest < ActiveSupport::TestCase

  should have_secure_password

  context "associations" do
    should have_many(:posts)
  end

  context "validations" do
    should validate_presence_of(:username)
    should validate_presence_of(:first_name)
    should validate_presence_of(:last_name)
    should validate_presence_of(:email)
    should validate_presence_of(:password)
  end

  test 'user creates a token after user is saved' do
    user = User.new(
      username: "weebrain",
      first_name: "Rita",
      last_name: "Britain",
      email: "tinyteddy@bumpaddle.com",
      password: "password"
    )
    refute user.token
    user.save
    assert user.token
  end

end
