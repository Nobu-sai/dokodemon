

require "test_helper"

class BlogPostsFeedHelperTest < ActionView::TestCase
  include BlogPostsFeedHelper
 
  def setup
    @michael = users(:michael) 
    @archer = users(:archer)
    @lana = users(:lana)
  end

  test "NO login => Should show all posts" do
    # Fulfill required state by BlogPostsFeedHelper 
      # How
      # - Login with INVALID information 
        # => NO Login is enrolled
        # P
        # - Make session Method availbe to check Login using SessionsHelper
        # post login_path, params: { session: { email:    @michael.email,
        # password: "invalid" } }
        # assert_not is_logged_in?      
      # - Log in with VALID information
        # -> Remember 
        # -> Log out -> Get Feed

      # post login_path, params: { session: { email:    @michael.email,
      #                                       password: 'password' } }
      # log_in_as(@michael)
      # assert logged_in?
      # log_out
      # # forget(current_user)
      assert_not logged_in?      

      

    # Fecth an Array of Feed
    # => Can not be used Active Record/all Method
      @blog_posts_feed = blog_posts_feed  
      
    # Confirm all the Blog Posts are contained in the Feed
      @blog_posts_feed.each do |blog_post|
        assert @blog_posts_feed.include?(blog_post)    
      end    
  end

  test "A user LOGGED in & different FOLLOW Relationship => Should have the Blog Posts by right users" do      
    current_user = @michael
    log_in_as(current_user)
	  @blog_posts_feed = blog_posts_feed 

    # Blog Posts by the users the Current User is FOLLOWING => Should BE included. 
      @blog_posts_feed.include?(@lana)

    # Self-posts for user WITH followers => Should BE included. 
      @blog_posts_feed.include?(current_user)
      
    current_user = @archer
    log_in_as(current_user)    
    
    # Self-posts for user WITHOUT followers => Should BE included.
      @blog_posts_feed.include?(current_user)

    # Blog Posts from the user the Current User is NOT following => A Blog Post by michael should NOT be included.
      @blog_posts_feed.include?(@michael)

  end
end