require 'test_helper'

class SessionsTrackPagePathPolicyTest < ActionDispatch::IntegrationTest  
	test "Send GET Request (whatever Controller Action)" do
 		# Test about
		#  - Instance Variables should be accessible"
		#  - The Values are corresponding to the Root Sent Request to 
		get root_path
		assert_response :success		
		assert session[:current_controller] = "static_pages" 
		assert session[:current_action] = "home"
		assert session[:string_path] = "static_pages#home"
	end
end