

require "test_helper"

class BlogPostsFeedHelperTest < ActionView::TestCase
  include BlogPostsFeedHelper
 
  def setup
    @michael = users(:michael) 
    @archer = users(:archer)
    @lana = users(:lana)
  end

  test "NO login => Should show all posts" do
      assert_not logged_in?      
      
    # Fecth an Array of Feed    
      @blog_posts_feed = blog_posts_feed  
      
    # Confirm all the Blog Posts are contained in the Feed      
      Blog.all.each do |blog_post|
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