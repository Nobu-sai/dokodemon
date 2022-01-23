
require "test_helper"
require "blog_posts_feed_query"

class BlogPostsFeedQueryTest < ActiveSupport::TestCase

  include SessionTrackBatchNumberHelper
  include CalculateTotalBatchesHelper

 
  def setup
    @michael = users(:michael) 
    @archer = users(:archer)
    @lana = users(:lana)
  end

  test "NO login => Should show all posts" do
    
    # Fetch the Blot Posts Feed 
      # => Expect the Feed includes ALL Blog Table Records
      all_blog_posts = []
        
      batch_size = 100
      total_batches = calculate_total_batches(batch_size)
      
      for i in 0..total_batches -1 do       
        @blog_posts_batch =  BlogPostsFeedQuery.new.fetch_blog_posts_as_a_batch(current_user: nil , batch_number: i, batch_size: batch_size)
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
	batch_size = 100
	current_user = @michael    

	  @blog_posts_batch =  BlogPostsFeedQuery.new.fetch_blog_posts_as_a_batch(current_user: current_user, batch_number: nil, batch_size: batch_size)

    # Blog Posts by the users the Current User is FOLLOWING => Should BE included. 
      @blog_posts_batch.include?(@lana)

    # Self-posts for user WITH followers => Should BE included. 
      @blog_posts_batch.include?(current_user)
      
      
    current_user = @archer    
    
    @blog_posts_batch =  BlogPostsFeedQuery.new.fetch_blog_posts_as_a_batch(current_user: current_user, batch_number: nil, batch_size: batch_size) 
    # Self-posts for user WITHOUT followers => Should BE included.
      @blog_posts_batch.include?(current_user)

    # Blog Posts from the user the Current User is NOT following => A Blog Post by michael should NOT be included.
      @blog_posts_batch.include?(@michael)

  end
end
