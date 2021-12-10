require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:michael)
  end

  
  test "SHOULD contain" do
    log_in_as(@user)
    get root_path(@user)
    assert_template 'static_pages/home'
    assert_select 'div.stats', count: 1
    assert_match @user.following.count.to_s, response.body
  end

end