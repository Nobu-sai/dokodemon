
### Instruction
## What this does
# - Return the Batch Number 
	# - The Batch needs to be shown in the NEXT Controller Response 
## When it is Called
# - In View, the user clicked the Feed Button (for the NEXT page to see)

## How to Develop
# - Do NOT manipulat the Session directly
	# => batch_number = session[:batch_number]
	# P
	# - Session is UPDATED, the purpose is ONLY CALCULATION of the Batch Number 
# - Do NOT UPDATE the Session here Batch Num
	# * Update of Session is done in app/services/session_track_batch_number_service.rb 
	# P
	# - If the session is updated here, the MEANT Batch Number is NOT returned -> ...


module CalculateBatchNumberHelper
	include CalculateTotalBatchesService

	
	def calculate_batch_number(clicked_button:, batch_size: )

		total_batches = calculate_total_batches(batch_size)
		
		batch_number = session[:batch_number]

		if clicked_button == "next" && session[:batch_number] < (total_batches) -1
			batch_number += 1
		elsif clicked_button == "previous" && session[:batch_number] > 0
			batch_number -= 1


		elsif clicked_button.is_a?(Integer)			
			batch_number = clicked_button - 1
					
		end	
		
		
		
		
	end

end