require 'test_helper'

class UserTest < ActiveSupport::TestCase

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

end
