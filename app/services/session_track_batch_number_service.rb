
module SessionTrackBatchNumberService

    def track_batch_number(batch_number) 
	puts "batch_number #{batch_number}"

	
	if !session[:batch_number] && batch_number == nil
		puts "SessionTrackBatchNumberService/track_batch_number/!session[:batch_number] Case"
		puts "session[:batch_number] #{session[:batch_number]}"
		return session[:batch_number] = 0 
		puts "session[:batch_number] #{session[:batch_number]}"
	else
		# Conditional for next or previous 
			# - In the View 
		puts "SessionTrackBatchNumberService/track_batch_number/Else Case"
		puts "session[:batch_number] #{session[:batch_number]}"
		return session[:batch_number] = batch_number.to_i
		puts "session[:batch_number] #{session[:batch_number]}"
	end
	
	end
end