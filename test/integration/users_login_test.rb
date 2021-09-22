require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest 

  def setup
    @user = users(:michael)
  end

  test "login with VALID email & INVALID password" do
    # P
      # Test the validity of email?
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email:    @user.email,
                                          password: "invalid" } }
    assert_not is_logged_in?
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "login with VALID information followed by logout" do
    get login_path
    post login_path, params: { session: { email:    @user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    
    
    # Simulate a user clicking logout in a second window AFTER the user ALREADY logged out in the FIRST window.
      # P
      # - An Issue	
        # - When the User opens MULTIPLE WINDOWS opening this SAME site 
    		# & If the user logged out in one window
    		# => Thereby setting current_user to nil, 
    		# => Clicking the “Log out” link in a second window would result in an error because of forget(current_user) in the log_out method
    delete logout_path
    follow_redirect!
    # Header
      assert_select "a[href=?]", login_path
      assert_select "a[href=?]", logout_path, count: 0
      assert_select "a[href=?]", user_path(@user), text: "Profile",count: 0
      # Now there ARE link_to @user inside Blog Posts Feed
    
  end
  
   test "login with remembering" do
    log_in_as(@user, remember_me: '1')
    assert_not cookies[:remember_token].blank?
  end

  test "login without remembering" do
    # Log in to set the cookie.
    log_in_as(@user, remember_me: '1')
    # Log in again and verify that the cookie is deleted.
    log_in_as(@user, remember_me: '0')
    assert cookies[:remember_token].blank?
  end
  
  
end