module SessionDefineBatchSizeHelper 
	def define_batch_size(batch_size)
		puts "batch_size #{batch_size}"
		if batch_size
			session[:batch_size] = batch_size.to_i
		else
			session[:batch_size] = 1000
		end	
	end
end