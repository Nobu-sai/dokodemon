

module UserShouldLoggedInPolicy
    def logged_in_user
      unless logged_in?
        store_location
        # For
          # - 
          # Keep CALL HERE
          # P
          # - One Call there 
          # - In a bunch of Code (Ex: A File) ONE Call for ONE purpose (whose NECESSITY was DEFINED there)
          #   => The CALLED Method Calls ANOTHER INDEPENDENT Method 
          #   P
          #   - Clean Code
          #     P
          #     - In a bunch of Code (Ex: A File) ONE Call for ONE purpose (whose NECESSITY was DEFINED there)
          #   - Composition
          #     P
          #     - "The CALLED Method Calls ANOTHER INDEPENDENT Method"
          # C
          # - Better with SRP in one Method
          #   C
          #    - It IS
            #   - For Login logic 
            #   - The Logic for storing previuos URL is ANOTHER component 
          #   P
          #   - Understand 
          #   - Maintenance
          #   - Test 
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end 
end