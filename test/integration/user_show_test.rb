
# For users/_user.html.erb
# Chack the Blot Posts about in test/fixtures/blogs.yml. 
require 'test_helper'

class UserShowTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @another_user = users(:malory)
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
      @another_user.blogs.create!(content: "A blog")
        # create! Method
          # => Makes the Blog Post REGARDLESS the Validation. 
      get users_path(@another_user) 
      assert_match "#{@another_user.blogs.count} Blog Post", response.body

  end

end