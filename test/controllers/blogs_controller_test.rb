require 'test_helper'

class BlogsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @blog = blogs(:orange)
  end

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
    
  test "should redirect destroy for wrong micropost" do
    log_in_as(users(:michael))
    blog = blogs(:ants)
    assert_no_difference 'Blog.count' do
      delete blog_path(blog)
    end
    assert_redirected_to root_url
  end
end
