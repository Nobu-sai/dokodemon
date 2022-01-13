module SessionDefineBatchSizeHelper 
	def define_batch_size(batch_size = nil)
		if batch_size
			session[:total_batches] = batch_size
		else
			session[:batch_size] = 100
		end	
	end
end