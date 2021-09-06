require 'test_helper'

class SharedBlogFormTest < ActionDispatch::IntegrationTest

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
end