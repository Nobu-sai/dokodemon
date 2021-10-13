require 'test_helper'

class SessionsStoreCurrentPathHelperTest < ActionDispatch::IntegrationTest  
	test "Send GET Request (whatever Controller Action) => Instance Variables should be accessible" do
		get root_path
		assert_response :success
		assert session[:current_controller] 
		assert session[:current_action]
	end
end