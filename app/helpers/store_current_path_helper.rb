module StoreCurrentPathHelper
   # Stores the URL trying to be accessed.
   def store_current_path(controller_name, action_name)
	# session[:current_path] = request.original_fullpath if request.get?
      # debugger session[:current_path] 
      # controller = params[:controller]
      # debugger controller
      # action = params[:action]

      # session[:current_path] = request.path
      # @controller = params[:controller].controller_name
      # @action = params[:controller].action_name
            if request.get? 
                  # session[:current_controller] = controller_name
                  # session[:current_action] = action_name
                  # @controller_name = controller_name
                  # @action_name = action_name
            else 
                  # debugger
            end     
            
      end
end