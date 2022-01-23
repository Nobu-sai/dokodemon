
module CalculateTotalBatchesHelper
	
    def calculate_total_batches(batch_size)
	# batch_size = session[:batch_size]
	@total_batches = Blog.count / batch_size
	(Blog.count - (Blog.count / batch_size * batch_size)) > 0 ? @total_batches += 1 : return 
	return @total_batches
	end

end