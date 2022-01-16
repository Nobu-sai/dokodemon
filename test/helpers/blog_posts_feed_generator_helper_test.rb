

require "test_helper"

class BlogPostsFeedGeneratorHelperTest < ActionView::TestCase
  include FetchBlogPostsHelper
  include SessionTrackBatchNumberHelper
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
        
      total_batches = calculate_total_batches(100)
      
      for i in 0..total_batches -1 do        
        @blog_posts_batch = fetch_blog_posts_as_a_batch("next", nil, 100)
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
    assert is_logged_in?     

	  @blog_posts_batch = fetch_blog_posts_as_a_batch(nil, nil, 100)

    # Blog Posts by the users the Current User is FOLLOWING => Should BE included. 
      @blog_posts_batch.include?(@lana)

    # Self-posts for user WITH followers => Should BE included. 
      @blog_posts_batch.include?(current_user)
      
    current_user = @archer
    log_in_as(current_user)    
    
    # Self-posts for user WITHOUT followers => Should BE included.
      @blog_posts_batch.include?(current_user)

    # Blog Posts from the user the Current User is NOT following => A Blog Post by michael should NOT be included.
      @blog_posts_batch.include?(@michael)

  end
end