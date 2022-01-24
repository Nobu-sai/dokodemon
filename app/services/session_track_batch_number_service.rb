
module SessionTrackBatchNumberService

    def track_batch_number(batch_number) 

	p
	
	if !session[:batch_number]
		puts "session #{session}"
		puts "session.class #{session.class}"
		puts "session[:batch_number] #{session[:batch_number]}"
		session[:batch_number] = 0 
	else
		# Conditional for next or previous 
			# - In the View 
		session[:batch_number] = batch_number.to_i
	end
	
	end
end