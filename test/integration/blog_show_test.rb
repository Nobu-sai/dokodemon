
require 'test_helper'

class UsersShowTest < ActionDispatch::IntegrationTest

  def setup
    @blog = blogs(:orange)
  end

  test "Should display right contents" do
	# get '/:username/blog/:title' => 'blogs#show', as: 'blog_post'
    get blog_post_path(:username => CGI.escape(blog.user.name).gsub('+','_'), :title => CGI.escape("BLOG-TITLE").gsub('+','_'), :blog_post_id => blog.id)
    assert_template 'blogs/show'
  end
end