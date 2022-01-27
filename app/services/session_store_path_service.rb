
module SessionStorePathService

    def session_store_path
      # What it does
      # - Stores the current URL | Controller Action
        # => Use as PREVIOUS Path
        # Usage
        # - Link (Ex: a Tag/href) there regardless the Controller Action wehre the View was Responded FROM (=> Only GET Request)
        # - In a Controller Action
        # 	- Respond a View File matching to the PREVIOUS URL where the user CAME FROM 
        # Case
        # - In app/controllers/sessions_controller.rb
        # 	- User Activated the Account -> Link the user Forward to where the one WAS or CAME FROM 
        # Src
        # - evernote:///view/180370944/s350/b6daee18-343c-fce3-f111-8355a38b91a2/77812575-71c1-4561-9362-9c31a7a32180              
    
    
          if request.get? 
                session[:responded_controller] = controller_name
                # For
                # - View/link_to 
                session[:responded_action] = action_name                             
                # For
                # - View/link_to 
                session[:responded_controller_action] = "#{controller_name}/#{action_name}"
                # For
                # - Controller/redirect 
                # - Controller/render 
                # Ex
                # - static_pages/home
          end     
    end

end