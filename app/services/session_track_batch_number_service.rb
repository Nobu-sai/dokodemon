

module SessionTrackBatchNumberService

    def track_batch_number(batch_number) 
	# batch_number Param
		# - The Feed Page Number (Actual Batch Nmuber + 1)
			# P
			# - Looks better (consistent to the Page Number) in URL Param to Pass 
		# - Looks better (consistent to the Page Number) in URL Param to Pass 
	puts "## app/services/session_track_batch_number_service.rb/track_batch_number(batch_number)"
	puts "session[:batch_number] #{session[:batch_number] }"
	puts "session[:batch_number].class #{session[:batch_number].class }"
	puts "batch_number #{batch_number}"
	puts "batch_number #{batch_number.class}"
	
	if !session[:batch_number] && batch_number == nil
		# Conditional for
		# - The FIRST time visit to the URL
			# => The user has no chance to click the Feed Button
			# =>> params[:page] is Nil
		return session[:batch_number] = 0  
	elsif session[:batch_number].is_a?(Integer)
		# Conditional for
		# - When the user clicked the Feed Button 		
		# - When this is Called MULTIPLE times with EMPTY param[:page] 
			# => In the FIRST Call, it Execute the TRUTHY Case and sets session[:batch_number] as 0 
			# => Thus, in the Second Call, it Executes FALSY Case and sets session[:batch_number] as -1 	
			# Case
				# - test/queries/blog_posts_feed_query_test.rb		
		return session[:batch_number] = (batch_number.to_i - 1)
	end
	
	end
end