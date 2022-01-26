

module UserShouldLogInPolicy
    def user_should_log_in
      unless logged_in?
        store_location
        # For
          # - The Page is Redirected to login_url -> User LOGIN -> Link BACK to the PREVIOUS URL 
          # Keep CALL HERE
          # P        
          # - In a bunch of Code (Ex: A File) ONE Call for ONE purpose (whose NECESSITY was DEFINED there)
          #   => The CALLED Method Calls ANOTHER INDEPENDENT Method 
          #   = evernote:///view/180370944/s350/ef1b9b61-62cf-359a-1d2f-7655535eb443/77812575-71c1-4561-9362-9c31a7a32180          
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end 
end