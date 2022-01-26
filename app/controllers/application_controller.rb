

class ApplicationController < ActionController::Base
  include SessionsHelper
  include SessionStoreCurrentPathHelper
  include LoggedInUserPolicy
  
  before_action :track_page_path
  
  private  

    # Confirms a logged-in user.
    def track_page_path
      session_store_current_path controller_name, action_name      
    end
end