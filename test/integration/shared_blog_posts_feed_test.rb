
# Instruciton
  # - Blog Post Feed is SHA.RED
require 'test_helper'

class SharedBlogPostsFeedTest < ActionDispatch::IntegrationTest
  include CalculateTotalBatchesHelper

  def setup
    @user = users(:michael)
    @blog = @user.blogs.first
    @user_2 = users(:archer)
  end


  # UI
  test "Should HAVE" do
    log_in_as(@user)
    get root_path

    # Links to each Blog Post Page.
      assert_select 'a', text: @blog.title
        # Should be actual Blog Title.

    # Links to delete OWN Blog Posts.
      assert_select 'a', text: 'Delete'  
    
    # Button for Feed Page or Batch Number 
      assert_select 'a', class: "feed-button__container" do
        assert_select 'a.feed-button'      
      end

      # Each Feed Button
        # First page 
          # fetch_blog_posts_as_a_batch(nil, nil, "100") 
          # define_batch_size
          # @total_batches = calculate_total_batches(100)
          @feed_button_amount = @total_batches + 1
            # One for each batch + Next
          assert_select 'a.feed-button', count: @feed_button_amount
        # Second page
          get root_path(params: { clicked_page: "2" })
          @feed_button_amount = @total_batches + 2
            # One for each batch + Next + Previous 

          assert_select 'a.feed-button', count: @feed_button_amount
        
    
  end  

  test "Should NOT have" do
    log_in_as(@user)
    
    # Visit ANOTHER user's profile page => Should NOT have Links to  delete the user's Blog Posts => Allows only the right user to delete.
      get user_path(users(:archer))
      assert_select 'a', { text: 'Delete', count: 0 }
  
  end

  # UX
    test "Click the Link to ROUTE to a Blog Post Page => Should Route to the Blog Page" do
      log_in_as(@user)     
      get blog_post_path(:username => url_encoding(@blog.user.name), :title => url_encoding("BLOG-TITLE"), :id => @blog.id)
      assert_template 'blogs/show'        
    end

    test "Click the Link to DELETE a Blog Post => Should decrease the Blog Count" do
      
      # Try to delete OWN Blog Posts.
        # * OTHER users' delete Link should NOT be had at first.
        log_in_as(@user)
        get root_path
        
        first_blog = @user.blogs.paginate(page: 1).first
        assert_difference 'Blog.count', -1 do
          delete blog_path(first_blog)
        end
    end  


  
end
