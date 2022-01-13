
module SessionTrackBatchNumberHelper
    def track_batch_number_session(direction = nil, clicked_page = nil) 
    
	
	if !session[:batch_number]
		session[:batch_number] = 0 
	else
		# Conditional for next or previous 
			# - In the View 
		if direction == "next"	
			session[:batch_number] += 1 
		elsif direction == "previous" 
			session[:batch_number] -= 1 
		elsif clicked_page 
			puts "clicked_page #{clicked_page}"
			session[:batch_number] = clicked_page.to_i - 1
		end					
			
	end
	
	end
end