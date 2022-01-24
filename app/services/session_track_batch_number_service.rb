
module SessionTrackBatchNumberService

    def track_batch_number(batch_number) 

	
	if !session[:batch_number]
		session[:batch_number] = 0 
	else
		# Conditional for next or previous 
			# - In the View 
		session[:batch_number] = batch_number.to_i
	end
	
	end
end