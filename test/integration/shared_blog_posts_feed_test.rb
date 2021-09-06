
# Instruciton
  # - Blog Post Feed is SHA.RED
require 'test_helper'

class SharedBlogPostsFeedTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @blog = @user.blogs.first
  end


  # UI
  test "Should HAVE" do
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination' 

    # Should HAVE Links to each Blog Post Page.
      assert_select 'a', text: 'BLOG-TITLE'
        # Should be actual Blog Title.

    # Should HAVE Links to delete OWN Blog Posts.
      assert_select 'a', text: 'Delete'  
    
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
      get blog_post_path(:username => CGI.escape(@blog.user.name).gsub('+','_'), :title => CGI.escape("BLOG-TITLE").gsub('+','_'), :id => @blog.id)
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
