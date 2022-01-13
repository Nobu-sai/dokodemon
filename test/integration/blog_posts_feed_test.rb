

require "test_helper"

class BlogPostsFeedTest < ActionView::TestCase
  include FetchBlogPostsHelper
  include SessionTrackBatchNumberHelper
  include SessionDefineBatchSizeHelper 
  include CalculateTotalBatchesHelper

 
  def setup
    @michael = users(:michael) 
    @archer = users(:archer)
    @lana = users(:lana)
  end

  test "NO login => Should show all posts" do
    assert_not logged_in?      
    
    # Fetch the Blot Posts Feed 
      # => Expect the Feed includes ALL Blog Table Records
      all_blog_posts = []
      
      define_batch_size
      @total_batches = calculate_total_batches
      
      for i in 0..@total_batches -1 do
        track_batch_number("next")
        @blog_posts_batch = fetch_blog_posts_as_a_batch
        @blog_posts_batch.each do | post |
          all_blog_posts << post           
        end
      end
      
      assert Blog.all.count == all_blog_posts.count
      
      Blog.all.each do | blog_post |             
        assert all_blog_posts.include?(blog_post)    
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