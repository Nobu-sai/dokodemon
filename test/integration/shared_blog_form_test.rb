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

  # UX
  test "Invalid submission" do
    log_in_as(@user)
    get root_path

    assert_no_difference 'Blog.count' do
      post blogs_path, params: { blog: { title: "" } }
    end
    assert_select 'div#error_explanation'
    
    assert_select 'a[href=?]', '/?page=2'  
      # => Confirm Ajax
      # => The URL should be should be AS IT WAS BEFORE the failed submission
      # P 
      #  - Issue 
        # When Wihtout Ajax & Failed Submission & Click a Pagination Button 
          # -  Since the Failed Submission (POST Request) changes the URL (Route to the Controller Action mathing to the Model) 
          # -> Clicking a Pagination Button will Link to ANOTHER or UNEXPECTED URL          
      
  end  

  test "Valid submission" do

    log_in_as(@user)
    get root_path
  
    title = "This blog really ties the room together"
    text = "#{'f' * 500}"
    image = fixture_file_upload('test/fixtures/kitten.jpg', 'image/jpeg')
    assert_difference 'Blog.count', 1 do
      post blogs_path, params: { blog:
                                    { title: title, text: text, image: image } }
    end
    assert assigns(:blog).image.attached?

    # After Response 
    assert_redirected_to root_url
    follow_redirect!    
    assert_match title, response.body      
      # => Confirm the NEW Blog Post is added to the Blog Feed
      # In the Home Page/Blog Feed 
      # => HAS blog.title & Has NO blog.text
  end
end