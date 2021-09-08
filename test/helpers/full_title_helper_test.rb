include FullTitleHelper

class FullTitleHelperTest < ActionView::TestCase

  test "full_title_helper Test" do
    base_title = "dokodemon"
    
    assert_equal full_title,         "#{base_title}"
    assert_equal full_title("Help"), "Help" + " | " + base_title
  end

end