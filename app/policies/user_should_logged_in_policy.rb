

module UserShouldLoggedInPolicy
    def logged_in_user
      unless logged_in?
        store_location
        # For
        # - Redirecting the user 
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end 
end