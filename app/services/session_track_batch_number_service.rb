

module SessionTrackBatchNumberService

    def track_batch_number(batch_number) 
	# batch_number Param
		# - The Feed Page Number (Actual Batch Nmuber + 1)
			# P
			# - Looks better (consistent to the Page Number) in URL Param to Pass 
		# - Looks better (consistent to the Page Number) in URL Param to Pass 
	if batch_number == nil || batch_number == 0 
		# batch_number == nil
		# For
			# - The FIRST time visit to the URL
				# => The user has no chance to click the Feed Button
				# =>> params[:page] is Nil
		# batch_number == 0 
			# - When this is Called MULTIPLE times with EMPTY param[:page] 
				# => In the FIRST Call, it Execute the TRUTHY Case and sets session[:batch_number] as 0 
				# => Thus, in the Second Call, it Executes FALTHY Case and sets session[:batch_number] as -1 	
				# Case
					# - test/queries/blog_posts_feed_query_test.rb		
		return session[:batch_number] = 0  
	else
		# Conditional for
		# - When the user clicked the Feed Button 		
		return session[:batch_number] = (batch_number.to_i - 1)
	end
	
	end
end