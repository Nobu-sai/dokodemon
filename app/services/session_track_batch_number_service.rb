

module SessionTrackBatchNumberService

    def track_batch_number(batch_number) 
	# batch_number Param
		# - The Feed Page Number (Actual Batch Nmuber + 1)
			# P
			# - Looks better (consistent to the Page Number) in URL Param to Pass 
		# - Looks better (consistent to the Page Number) in URL Param to Pass 
	
	# Values here
		# session[:batch_number] 
			# session[:batch_number] #=> -1
			# session[:batch_number] == -1 #=> true
			# !session[:batch_number] #=> false
			# !session[:batch_number] == true #=> false
		# batch_number 
			# batch_number == nil #=> true
	
	if session[:batch_number] == -1 || batch_number == 0	
		# puts "## track_batch_number/!session[:batch_number] || batch_number == 0"
		puts "## track_batch_number/session[:batch_number] == nil || batch_number == 0"
		# !session[:batch_number]
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
	# elsif session[:batch_number] > 0 
	# elsif session[:batch_number].is_a?(Integer) && session[:batch_number] > 0 
	# elsif !session[:batch_number] == nil || session[:batch_number] > 0 
	else
		puts "## track_batch_number/elsif session[:batch_number] > 0"
		# Conditional for
		# - When the user clicked the Feed Button 		
		return session[:batch_number] = (batch_number.to_i - 1)
	# else
	# 	return
	end


	
	end
end