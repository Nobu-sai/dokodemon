require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:michael)
  end

  test "Showing the user profile => Should contain required contents" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.name)
    assert_select 'h1', text: @user.name
    assert_select 'h1>img.gravatar'

    # User blogs
      assert_match @user.blogs.count.to_s, response.body
      assert_select 'div.pagination', count: 1
      @user.blogs.paginate(page: 3).each do |blog|
        assert_match blog.title, response.body        
      end
  end
  
  test "Shoing the user profile STATS (follow) on the Home Page => Should contain required contents" do
    log_in_as(@user)
    get root_path(@user)
    assert_template 'static_pages/home'
    assert_select 'div.stats', count: 1
    assert_match @user.following.count.to_s, response.body
    assert_match @user.followers.count.to_s, response.body
  end

end