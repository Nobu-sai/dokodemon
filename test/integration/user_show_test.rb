
# For users/_user.html.erb
# Check the Blog Posts in test/fixtures/blogs.yml. 
require 'test_helper'
include UrlEncodingHelper

class UserShowTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @another_user = users(:malory)
  end

  test "SHOULD contain" do
    # HTML File and its contents
      get user_path(@user, page: 1000)
      assert_template 'users/show'
      assert_select 'title', full_title(@user.name)
      assert_select 'h1', text: @user.name
      assert_select 'h1>img.gravatar'
      assert_match @user.blogs.count.to_s, response.body
      assert_template 'shared/_stats'  

    
      # Render Blogs Posts Feed (ones by the user)
      assert_select 'div.pagination', count: 1
      
      @user.blogs.paginate(page: 1000).each do |blog|
        assert_match url_encoding(blog.title), response.body         
      end
      
  end
  

  test "Users with different amount of Blog Posts => Show DIFFERENT Blog Post Counts" do
   
    log_in_as(@user)
    get users_path(@user)
    assert_response :success

    assert_match "#{@user.blogs.count} Blog Posts", response.body
    
    # ANOTHER user with ZERO Blog Posts. => Blog count should be ZERO. 
      log_in_as(@another_user) 
      get users_path(@another_user)
      assert_match "#{@another_user.blogs.count} Blog Posts", response.body
   
      # ANOTHER user MADE a Blog Post => Blog count should INCREASE.
      @another_user.blogs.create!(title: "BLOG-TITLE", text: "BLOG-TEXT")
        # create! Method
          # => Makes the Blog Post REGARDLESS the Validation. 
      get users_path(@another_user) 
      assert_match "#{@another_user.blogs.count} Blog Post", response.body      

  end

end