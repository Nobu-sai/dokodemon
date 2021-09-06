
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
    # get '/:username/blog/:title' => 'blogs#show', as: 'blog_post'
    get blog_post_path(:username => CGI.escape(@blog.user.name).gsub('+','_').gsub(/\./, '_'), :title => CGI.escape("BLOG-TITLE").gsub('+','_'), :id => @blog.id)
    assert_template 'blogs/show'
    assert_select 'title', "TITLE - #{@blog.user.name} | dokodemon"

  end
end