require 'test_helper'

class PostTest < ActiveSupport::TestCase

  context "associations" do
    should belong_to(:user)
  end

  context "validations" do
    should validate_presence_of(:body)
  end

  test 'post body cannot be blank' do
    post = Post.new(body: "")
    refute response.ok?
    json = JSON.parse
    assert post.errors.full_messages.include?("Body can't be blank")
  end

end
