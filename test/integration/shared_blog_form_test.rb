require 'test_helper'

class SharedBlogFormTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  # UI
  test "SHOULD have" do
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination'
    
    # Form Inputs
      assert_select 'input[type=text]'
      assert_select 'textarea'
      assert_select 'input[type=file]'
      assert_select 'input[type=submit]'
    
  end

  # # UX
  # test "Invalid submission" do
  #   log_in_as(@user)
  #   get root_path

  #   assert_no_difference 'Blog.count' do
  #     post blogs_path, params: { blog: { title: "" } }
  #   end
  #   # assert_select 'div#error_explanation'
    
  #   # assert_select 'a[href=?]', '/?page=2'  
  #   #   # What to Test
  #   #   # - X Confirm Ajax
  #   #     # => The URL should be should be AS IT WAS BEFORE the failed submission
  #   #     # * Actually, the URL should NOT change
  #   #     # * BUT, it is NOT relevant to Pagination Button Links
  #   #   # - Confirm the Pagination Button Links (a Tag href) NOT to change | to be AS it WAS
  #   #     # - IF the Link was clicked in Home Page, 
  #   #       # => The URL should be Home Page
  #   #     # P 
  #   #     #  - Issue 
  #   #       # = A user Sends Failed Submission 
  #   #         # -> A user vlicks a Pagination Button 
  #   #         # -> Rails Links to UNEXPECTED page DIFFERENT from where the user WAS  
  #   #           # Ex
  #   #           # - Home Page (as StaticPageController/home Action) Sending Failed Submission to BlogsController/create Action)
  #   #             # - evernote:///view/180370944/s350/8e940c01-e0ca-9522-5f08-87ab3746f3a1/77812575-71c1-4561-9362-9c31a7a32180
  #   #     # How
  #   #     # - evernote:///view/180370944/s350/0a9efe6d-50e4-cb9a-1c21-9568aa68b0f2/77812575-71c1-4561-9362-9c31a7a32180 
  # end  

  # test "Valid submission" do

  #   log_in_as(@user)
  #   get root_path
  
  #   title = "This blog really ties the room together"
  #   text = "#{'f' * 500}"
  #   image = fixture_file_upload('test/fixtures/kitten.jpg', 'image/jpeg')
  #   assert_difference 'Blog.count', 1 do
  #     post blogs_path, params: { blog:
  #                                   { title: title, text: text, image: image } }
  #   end
  #   # assert assigns(:blog).image.attached?

  #   # After Response 
  #   assert_redirected_to root_url
  #   follow_redirect!    
  #   # assert_match title, response.body      
  #   #   # => Confirm the NEW Blog Post is added to the Blog Feed
  #   #   # In the Home Page/Blog Feed 
  #   #   # => HAS blog.title & Has NO blog.text
  # end
end