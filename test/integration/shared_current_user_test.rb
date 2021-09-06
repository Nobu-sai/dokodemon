
require 'test_helper'

class SharedCurrentUserTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end
end