

require "test_helper"

class BlogPostsFeedHelperTest < ActionView::TestCase
  include BlogPostsFeedHelper
 
  def setup
    @michael = users(:michael) 
    @archer = users(:archer)
    @lana = users(:lana)
  end

  # Output = Feed should have ALL Blog Posts   
  test "NO Login" do
    # What to do
    # /Requerements
    # X - Fulfill required LOGIN state by BlogPostsFeedHelper 
      # C
      # - Now NO LOGIN required
    # /Subject
    # - Feed should have ALL the Blog Posts

      
      assert_not logged_in?      

      
    # Feed should have ALL the Blog Posts
      # blog_posts_feed.each do |blog_post| 
      Blog.all.each do |blog_post|
        # assert blog_posts_feed.include?(blog_post)    
        # assert Blog.all.include?(blog_post)    
        # assert_includes(Blog.all, blog_post)
        assert_includes(blog_posts_feed, blog_post)
      end    
      
  end
  
  # Output = Feed Should have the Blog Posts by right users
  test "WITH Login & Having different FOLLOW Relationship (Ex: Follows others or not)" do      
    current_user = @michael
    log_in_as(current_user)
	  @blog_posts_feed = blog_posts_feed 

    # Blog Posts by the user the Current User is FOLLOWING => Should BE included. 
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