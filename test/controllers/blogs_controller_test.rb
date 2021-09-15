require 'test_helper'

class BlogsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @blog = blogs(:orange)
    @user = users(:michael)
  end

  # Routing
    test "Request to the index Action => Should Route to the Index Page." do        
      # Request and Reponse
        get blogs_path
        assert_response :success      

    end

    test "Request to the show Action with DEFAULT URL with ID => Should Route to the _blog.html.erb." do   
      # P
        # - Since do NOT set blog.id in the URL => I cannot send => I cannot test the feasibility. => Have a test for DEFAULT URL with show Action.
      log_in_as(@user)
        # = Needed to assign Valud to current_user Variable used in app/views/shared/_user_info.html.erb
      get blog_path(@blog.id)
      assert_response :success
  
    end  

    test "Request to the show Action with CUSTOM URL => Should Route to the Blog Page." do   
      # Request with specific URL 
        # Assets
          # get '/:username/blog/:title' => 'blogs#show', as: 'blog_post'
          # get blog_post_path(:username => CGI.escape(blog.user.name).gsub('+','_'), :title => CGI.escape("BLOG-TITLE").gsub('+','_'), :blog_post_id => blog.id)
        # How
          # The encoding is done in url_encoding_helper_test.rb

        user_name = "user_name"
        blog_title = "blog_title"
        assert_routing "/#{user_name}/blog/#{blog_title}", 
          controller: 'blogs', 
          action: 'show', 
          username: "#{user_name}",
          title: "#{blog_title}"
    end


  # Redirect 
    test "User NOT logged in & Try to create a Blog Post => Should Redirect to the Home Page" do
      assert_no_difference 'Blog.count' do
        post blogs_path, params: { blog: { title: "Lorem ipsum", text: "#{'f' * 500}'" } }
      end
      assert_redirected_to login_url
    end

    test "User NOT logged in & Try to delete a Blog Post => Should Redirect" do
      assert_no_difference 'Blog.count' do
        delete blog_path(@blog)
      end
      assert_redirected_to login_url
    end
      
    test "User LOGGED in & Try to delete WRONG Blog Post => Should Redirect" do
      log_in_as(users(:michael))
      blog = blogs(:ants)
      assert_no_difference 'Blog.count' do
        delete blog_path(blog)
      end
      assert_redirected_to root_url
    end
end
