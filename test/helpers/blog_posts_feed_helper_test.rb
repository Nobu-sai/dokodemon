

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
      # @blog_posts_feed = blog_posts_feed(1)  
      # @blog_posts_feed_2 = blog_posts_feed(2)  
           
      
    # Confirm ALL the Blog Posts are contained in the Feed      
      # Blog.all.each do |blog_post|
      #   assert @blog_posts_feed.include?(blog_post)    
      # end           

      
        @blog_posts_feed
        batch_size_number = 100
        blog_records_number = Blog.count
        total_fetch_call_number = blog_records_number / batch_size_number
        current_fetch_call_number = 1
        current_batch_start = 1        

        while current_fetch_call_number <= total_fetch_call_number do 
          all_blog_posts = Blog.includes(:user, image_attachment: :blob).in_batches(of: batch_size_number, start: current_batch_start)
          all_blog_posts.each do | blog_post | 
            @blog_posts_feed = blog_posts_feed(current_fetch_call_number, batch_size_number)   
            assert @blog_posts_feed.include?(blog_post)    
          end
          current_fetch_call_number += 1
          current_batch_start += batch_size_number

          # If all the blog posts 
        
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