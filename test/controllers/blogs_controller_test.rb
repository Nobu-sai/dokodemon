# Src
# - evernote:///view/180370944/s350/97aba4df-8996-79b0-b6d4-e733058166c3/77812575-71c1-4561-9362-9c31a7a32180
require 'test_helper'

class BlogsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @blog = blogs(:orange)
    @user = users(:michael)
 
  end

  # GET 
    test "GET Request to the index Action => Should Route to the Index Page." do        
      # Request and Reponse
        get blogs_path
        assert_response :success      

    end

    test "GET Request to the show Action & DEFAULT URL with ID" do   
      # P
        # - Since do NOT set blog.id in the URL => I cannot send => I cannot test the feasibility. => Have a test for DEFAULT URL with show Action.
      log_in_as(@user)
        # = Needed to assign Valud to current_user Variable used in app/views/shared/_user_info.html.erb
      get blog_path(@blog.id)
      assert_response :success
  
    end  

    test "GET Request to the show Action & CUSTOM URL" do   
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

    # POST/Valid
    test "POST Request (Ajax) to the create Action & Valid" do

      log_in_as(@user)
      get root_path
      assert_equal request.fullpath, root_path
 
      title = "TITLE"
      text = "#{'f' * 500}"
      image = fixture_file_upload('test/fixtures/kitten.jpg', 'image/jpeg')
      assert_difference 'Blog.count', 1 do

        post blogs_path, 
          params: { blog:{ title: title, text: text, image: image } }

        # post blogs_path, 
        #   params: { blog:{ title: title, text: text, image: image } },
        #   xhr: true
          # C
          # - Using Ajax (XML) result in "all Status in 200" => Bad for Test
            # - Wander Solving is being suspended
            # P
            # - (Me) "DoKoDeMon"/"Issue" (22/09/2021)/"Case" = In BlogsController/create Action/FAILED Case/Response & Test/Success & Failure; About Ajax or not
              # = evernote:///view/180370944/s350/367d324b-f2d5-bf57-6895-5cd18cd83401/77812575-71c1-4561-9362-9c31a7a32180
      end      
      assert_equal request.fullpath, blogs_path
      assert assigns(:blog).image.attached?
      
      assert_response 302
       # Redirect 
      assert_redirected_to root_url       
      follow_redirect!    
      assert_match title, response.body             
        # => Confirm the NEW Blog Post is added to the Blog Feed
        # In the Home Page/Blog Feed 
        # => HAS blog.title & Has NO blog.text

      assert_template "static_pages/home"      
        # Case
        # - VALID Submission => Redirect
          # => expecting <"static_pages/home"> but rendering with <[]>
    end

    # POST/Inalid
    test "POST Request (Ajax) to the create Action & Invalid" do     

      log_in_as(@user)
      get root_path
        # => Sets the current Controller Action for will_paginate Pagination Link href
          # P
          # - Otherwise, 
            # In app/views/shared/_blog_posts_feed.html.erb:11 (will_paginate Method) 
            # Error Message: ActionView::Template::Error: undefined method `start_with?' for nil:NilClass
      title = ""
      text = "#{'f' * 500}"
      assert_no_difference 'Blog.count' do
        post blogs_path, 
          params: { blog:{ title: title, text: text } }
        
        # post blogs_path, 
        #   params: { blog:{ text: text } },
        #   xhr: true
           # C
          # - Using Ajax (XML) result in "all Status in 200" => Bad for Test
            # - Wander Solving is being suspended
            # P
            # - (Me) "DoKoDeMon"/"Issue" (22/09/2021)/"Case" = In BlogsController/create Action/FAILED Case/Response & Test/Success & Failure; About Ajax or not
              # = evernote:///view/180370944/s350/367d324b-f2d5-bf57-6895-5cd18cd83401/77812575-71c1-4561-9362-9c31a7a32180

      end      
      assert_response 400      
      assert_template "static_pages/home"
        # => Checks the Response
      # NOT
      # > assert_equal request.fullpath, blogs_path
        # C
        # - It's just normal POST Request 
        # - As for Ajax, it's NOT relavant.
      # > assert_equal request.fullpath, root_path
        # C
        # - The Request Route is BlogsController which is as EXPECTED.
        # X - What important as Ajax is the ASYNCHRONOUS process keeping the URL different form the Request Route

      assert_select 'div#error_explanation'
      
      get root_path
      assert_template "static_pages/home" 
      # => For the Issue Solution: 
        # - User Post a Blog with INVALID inputs
          # => View File should be kept as it was (Ex: static_pages/home)      
        # -> User Clicks a will_paginate/Paigination Button 
          # => View File should be KEPT as it WAS (Ex: static_pages/home)
          # P: Mock the GET Request with the Controller Action for the PAGE as IT WAS
            # => Checks the will_paginate Method/params/Routing Parameters are WORKING correctly
    end

  # POST/Inalid/Redirect
    test "User NOT logged in & Try to create a Blog Post" do
      assert_no_difference 'Blog.count' do
        post blogs_path, params: { blog: { title: "Lorem ipsum", text: "#{'f' * 500}'" } }
      end
      assert_redirected_to login_url
    end

    test "User NOT logged in & Try to delete a Blog Pos" do
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
