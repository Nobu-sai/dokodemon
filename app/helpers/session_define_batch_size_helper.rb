module SessionDefineBatchSizeHelper 
	def define_batch_size(batch_size = nil)
		if batch_size
			session[:batch_size] = batch_size
		else
			session[:batch_size] = 1000
		end	
	end
end