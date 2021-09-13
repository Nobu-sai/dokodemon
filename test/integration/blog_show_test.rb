
require 'test_helper'

class BlogShowTest < ActionDispatch::IntegrationTest

  def setup
    @blog = blogs(:orange)
    @user = users(:michael)
  end

  # UI
  test "Requested with DEFAULT URL" do

  end
  test "Requested with CUSTOM URL" do
    log_in_as(@user)
    # Assets
      # get '/:username/blog/:title' => 'blogs#show', as: 'blog_post'
    # How
      # The encoding is done in url_encoding_helper_test.rb 
    
    get blog_post_path(:username => @blog.user.name , :title => @blog.title, :id => @blog.id)
    assert_template 'blogs/show'
    assert_select 'title', full_title("#{@blog.title} - #{@blog.user.name}")
      # = For Rails/ERb/provide Method
      # = NOT for URL Encoding.
      # => Should test if the Responded Blog Post's user name (@blog.user.name) is used.

    assert_match @user.name, response.body
    assert_match @blog.title, response.body
    assert_match @blog.text, response.body
    assert_select 'div>img.gravatar'
  end
end