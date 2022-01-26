
module SessionTrackPagePathPolicy

    def track_page_path
      # What it does
      # - Stores the current URL | Controller Action
        #  => Link (Ex: a Tag/href) there regardless the Controller Action wehre the View was Responded FROM (=> Only GET Request)
        # Src
        # - evernote:///view/180370944/s350/b6daee18-343c-fce3-f111-8355a38b91a2/77812575-71c1-4561-9362-9c31a7a32180              
          if request.get? 
                session[:current_controller] = controller_name
                session[:current_action] = action_name                             
                session[:string_path] = "#{controller_name}/#{action_name}"
          end     
    end

end