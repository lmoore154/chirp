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
    refute post.save
    assert post.errors.full_messages.include?("Body can't be blank")
  end

  test 'post body cannot be longer than 160 characters' do
    post = Post.new(body: ("0" * 161))
    refute post.save
    assert post.errors.full_messages.include?("Body is too long (maximum is 160 characters)")
  end


end
