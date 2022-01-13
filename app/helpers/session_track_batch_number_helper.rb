
module SessionTrackBatchNumberHelper
    def track_batch_number(direction = nil, clicked_page = nil) 
    
	
	if !session[:batch_number]
		session[:batch_number] = 0 
	else
		# Conditional for next or previous 
			# - In the View 
		if direction == "next" && session[:batch_number] < (calculate_total_batches) -1
			# session[:batch_number] < (calculate_total_batches) -1
				# Pro
				# - Problem > whqen - next button to the last page -> refresh- click next feed button > what - undefined method `count' for nil:NilClass 
					# = 523998b75fb6222533d179124ee81691a2b75ac0
			session[:batch_number] += 1 
		elsif direction == "previous" && session[:batch_number] > 0
			session[:batch_number] -= 1 

		elsif clicked_page 
			puts "clicked_page #{clicked_page}"
			session[:batch_number] = clicked_page.to_i - 1
		end					
			
	end
	
	end
end