
module CalculateBatchNumberHelper
	include CalculateTotalBatchesService

	
	def calculate_batch_number(clicked_button:, batch_size: )

		total_batches = calculate_total_batches(batch_size)
	
		if clicked_button == "next" && session[:batch_number] < (total_batches) -1
			# session[:batch_number] < (calculate_total_batches) -1
				# Pro
				# - Problem > whqen - next button to the last page -> refresh- click next feed button > what - undefined method `count' for nil:NilClass 
					# = 523998b75fb6222533d179124ee81691a2b75ac0
			session[:batch_number] += 1 
		elsif clicked_button == "previous" && session[:batch_number] > 0
			session[:batch_number] -= 1 

			
		elsif clicked_button.is_a(Integer)			
			session[:batch_number] = clicked_button - 1
		else
			session[:batch_number]
		end					
	end

end