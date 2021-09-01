require "test_helper"

class PlaceCommentTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @place = places(:example_place_1)
    # This code is not idiomatically correct.
    # @place_comment = PlaceComment.new(content: "Lorem ipsum", user_id: @user.id, place_id: @place.id)
    @place_comment = @place.place_comments.build(content: "Lorem ipsum", user_id: @user.id)
      # - No needs for place_id Assignment
        # P
        # - The @place_comment is made based on the Association with @place => place_id is AUTOMATICALLY set with @place.
  end

  test "should be valid" do
    assert @place_comment.valid?
  end

  test "user id should be present" do
    @place_comment.user_id = nil
    assert_not @place_comment.valid?
  end

  test "place id should be present" do
    @place_comment.place_id = nil
    assert_not @place_comment.valid?
  end
end

