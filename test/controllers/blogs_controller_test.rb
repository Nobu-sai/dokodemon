require 'test_helper'

class BlogsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @blog = blogs(:orange)
  end

  # show Action
  test "GET Request => Should Route to the Blog Page." do 
    get blog_path(@blog.id)
   
    # get '/:username/blog/:title' => 'blogs#show', as: 'blog_post'
      get blog_post_path(:username => CGI.escape(blog.user.name).gsub('+','_'), :title => CGI.escape("BLOG-TITLE").gsub('+','_'), :blog_post_id => blog.id)
      assert_response :success
  end


  # create Aciton
    test "should redirect create when not logged in" do
      assert_no_difference 'Blog.count' do
        post blogs_path, params: { blog: { content: "Lorem ipsum" } }
      end
      assert_redirected_to login_url
    end

    test "should redirect destroy when not logged in" do
      assert_no_difference 'Blog.count' do
        delete blog_path(@blog)
      end
      assert_redirected_to login_url
    end
      
    test "should redirect destroy for wrong blog" do
      log_in_as(users(:michael))
      blog = blogs(:ants)
      assert_no_difference 'Blog.count' do
        delete blog_path(blog)
      end
      assert_redirected_to root_url
    end
end
