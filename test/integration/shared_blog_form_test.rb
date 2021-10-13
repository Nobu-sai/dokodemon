require 'test_helper'

class SharedBlogFormTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  # UI
  test "SHOULD have" do
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination'
    
    # Form Inputs
      assert_select 'input[type=text]'
      assert_select 'textarea'
      assert_select 'input[type=file]'
      assert_select 'input[type=submit]'
    
  end

end