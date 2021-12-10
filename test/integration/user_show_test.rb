
# For users/_user.html.erb
# Check the Blog Posts in test/fixtures/blogs.yml. 
require 'test_helper'
include BlogPostsFeedHelper
include UrlEncodingHelper

class UserShowTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @another_user = users(:malory)
  end

  test "SHOULD contain" do
    # HTML File and its contents
      get user_path(@user, page: 1000)
      assert_template 'users/show'
      assert_select 'title', full_title(@user.name)
      assert_select 'h1', text: @user.name
      assert_select 'h1>img.gravatar'
      assert_match @user.blogs.count.to_s, response.body
      assert_template 'shared/_stats'  

    
      # Render Blogs Posts Feed (ones by the user)
      assert_select 'div.pagination', count: 1

      
      # debugger
      # @user.blogs.paginate(page: 1).each do |blog| 
      @user.blogs.paginate(page: 1000).each do |blog|
        # debugger
      # @user.blogs.paginate(page: 11).each do |blog|
      # @user.blogs.paginate(page: 12).each do |blog|
      # @user.blogs.paginate(page: 13).each do |blog|
      # @user.blogs.paginate(page: 300).each do |blog|
      # @user.blogs.paginate(page: 3000).each do |blog|
        # debugger
      # @user.blogs.paginate(page: 11).each do |blog|
      # @user.blogs.paginate(params[:page]).each do |blog|
      # blog_posts_feed.each do | blog | 

        # assert_match blog, response.body        
        # assert_match blog.title, response.body        
        assert_match url_encoding(blog.title), response.body         
        # response.body =~ blog.title
        # blog_title = Regexp.new Regexp.escape blog.title if String === blog.title
        # assert response.body =~ blog_title
        # assert blog_title =~ response.body
        # debugger 
        # put blog_title =~ response.body 

        # puts response.body =~ blog.title 
        # puts response.body =~ Regexp.new Regexp.escape blog.title 

        # assert_match response.body, blog.title
        # assert_match response.body, Regexp.escape blog.title
        # assert_match response.body, Regexp.new(Regexp.escape(blog.title))

        # response.body.match?(blog.title)
        # blog.title.match?(response.body)
        # blog.title.match(response.body)
        # response.body.match(blog.title)

      end
  end
  

  test "Users with different amount of Blog Posts => Show DIFFERENT Blog Post Counts" do
   
    log_in_as(@user)
    get users_path(@user)
    assert_response :success

    assert_match "#{@user.blogs.count} Blog Posts", response.body
    
    # ANOTHER user with ZERO Blog Posts. => Blog count should be ZERO. 
      log_in_as(@another_user) 
      get users_path(@another_user)
      assert_match "#{@another_user.blogs.count} Blog Posts", response.body
   
      # ANOTHER user MADE a Blog Post => Blog count should INCREASE.
      @another_user.blogs.create!(title: "BLOG-TITLE", text: "BLOG-TEXT")
        # create! Method
          # => Makes the Blog Post REGARDLESS the Validation. 
      get users_path(@another_user) 
      assert_match "#{@another_user.blogs.count} Blog Post", response.body

  end

end