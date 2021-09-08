require 'test_helper'
include ActionView::Helpers::AssetTagHelper
include UserGravatarHelper

class UsersGravatarHelperTest < ActionDispatch::IntegrationTest
	
	def setup
		@user = users(:example_user)		
	end

	test "UserGravatarHelper Test" do
		gravatar = user_gravatar(@user, size: 50 )
		assert gravatar.presence		

	end

end
  