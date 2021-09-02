require 'test_helper'

class BlogsInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "In the Home Page/Blog Form, try to submit a new blog => Should validate right and wrong submission. & route the page." do
    log_in_as(@user)
    get root_path
    # assert_select 'div.pagination'
    assert_select 'input[type=file]'
    # Invalid submission
      assert_no_difference 'Blog.count' do
        post blogs_path, params: { blog: { content: "" } }
      end
      assert_select 'div#error_explanation'
      assert_select 'a[href=?]', '/?page=2'  # Correct pagination link
    # Valid submission
      content = "This blog really ties the room together"
      image = fixture_file_upload('test/fixtures/kitten.jpg', 'image/jpeg')
      assert_difference 'Blog.count', 1 do
        post blogs_path, params: { blog:
                                      { content: content, image: image } }
      end
      assert assigns(:blog).image.attached?
      assert_redirected_to root_url
      follow_redirect!
      assert_match content, response.body
  end
  
  test "In the Home Page, view blog contents => Should contain right contents." do
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination'    

    # Delete post.
      assert_select 'a', text: 'delete'
      first_micropost = @user.blogs.paginate(page: 1).first
      assert_difference 'Blog.count', -1 do
        delete blog_path(first_blog)
      end
    # Visit as a different user => NO delete links => Allows only the right user to delete.
      get user_path(users(:archer))
      assert_select 'a', { text: 'delete', count: 0 }
  end  
  
  test "In the Home Page, Blog sidebar count" do
    log_in_as(@user)
    get root_path
    assert_match "#{@user.blogs.count} blogs", response.body
    # A user with zero blogs visits ones's Home Page => Blog count should be ZERO.
      other_user = users(:malory)
      log_in_as(other_user)
      get root_path
      assert_match "0 blogs", response.body
    # A user with zero blogs post a new blog => Blog count should INCREASE.
      other_user.blogs.create!(content: "A blog")
      get root_path
      assert_match "1 blog", response.body
  end
end
