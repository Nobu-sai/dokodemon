require "test_helper"

class PlaceTest < ActiveSupport::TestCase
  def setup     
    @place = places(:example_place_1)
  end

  test "should be valid" do
    assert @place.valid?
  end

  test "place name should be present" do
    @place.name = nil
    assert_not @place.valid?
  end

  test "name should be present" do
    @place.name = "   "
    assert_not @place.valid?
  end

  test "name should be at most 140 characters" do
    @place.name = "a" * 141
    assert_not @place.valid?
  end

end
