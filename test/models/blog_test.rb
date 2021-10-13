require 'test_helper'

class BlogTest < ActiveSupport::TestCase

  def setup
    @user = users(:michael)
    @blog = @user.blogs.build(title: "Lorem ipsum", text: "#{'f'*500}")
    # No needs for user_id
      # P
      # - The blog Model is ASSOCIATED with user Model => The user_id is AUTOMATICALLY added when making a new blog post Noting a user.
  end

  # Valid
  test "Valid Blog Post Submission => Valid" do
    assert @blog.valid?
  end

  # Invalid
  test "Blog Post Submission (WITHOUT a user_id Field) => Invalid" do
    @blog.user_id = nil
    assert_not @blog.valid?
  end
  
  test "Blog Post Submission (WITHOUT REQUIRED contents) => Invalid" do
    @blog.title = "   "
    assert_not @blog.valid?
  end

  test "Blog Post Submission (ABOVE the LIMIT text length (140)) => Invalid" do
    @blog.title = "a" * 141
    assert_not @blog.valid?
  end
  
  test "Fetch the FIRST blog post => It should be the meant ORDER (MOST RECENT posted blog post)" do
    assert_equal blogs(:most_recent), Blog.first
  end
  
end