

class ApplicationController < ActionController::Base
  include SessionsHelper
  include SessionStoreCurrentPathHelper
  include FetchBlogPostsHelper
  before_action :track_page_path
  
  private  

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end 
    def track_page_path
      session_store_current_path controller_name, action_name      
    end
end