# What it does
# - Fetch Blog Records -> Return an Array has BATCHES of Records
	# - Fetch Blog Records as Batches 
	#   => in_batches
	# - Store each Batch into an Array -> Return it 
	#   => @blog_posts_feed
# Facts
# - The Returned Object (by in_batches) is ActivbeRecord::Relation Class => Records are editable

# How to use
# - Send Batch size 
# - Loop over the Array -> Show | Edit 

module BlogPostsFeedHelper
	include SessionsHelper
	
  # Fetch the right Blog Posts 
  # => Becomes the Array of Blog Posts diaplayed in the a proto-feed View (app/views/shared/_blog_posts_feed.html.erb).      
    def blog_posts_feed(direction)

	@blog_posts_batches = []
	batch_size = 100
	@total_batches = Blog.count / batch_size 

	session[:batch_number] = 0 
	if session[:batch_number]
		# Conditional for next or previous 
			# - In the View 
		if direction == "next"		
			session[:batch_number] += 1		
		elsif direction == "previous" 
			session[:batch_number] -= 1
		end
		
		
	end
	


	# IF the user IS logged in
	if logged_in?
		# What to do
		# - The posts for the users the OGGED IN user is FOLLOWING 
		# - The posts for the LOGGED IN user ONESELF
		# Src
		# - evernote:///view/180370944/s350/19623e87-a598-3cc0-6e19-144553d84ec2/77812575-71c1-4561-9362-9c31a7a32180
		following_ids = current_user.set_following_ids_query
			
		# Get the Blog Posts based on the gotten ids		
		 Blog.where("user_id IN (#{following_ids})
				OR user_id = :current_user_id", current_user_id: "#{current_user.id}")
				.includes(:user, image_attachment: :blob)				
				
					# = Eager Loading
						# - For Active Storage n + 1 Query Problem 		
							# evernote:///view/180370944/s350/1ab665fe-df8c-1211-4eac-6c4571986d4c/77812575-71c1-4561-9362-9c31a7a32180		
	# IF the user is NOT logged in
	else
		# What to do
		# - Show ALL Blog Posts in reverse chronological order (latest at top)
		
		 blog_posts_batches = Blog.includes(:user, image_attachment: :blob).in_batches(of: batch_size)		
		blog_posts_batches.each do | batch |
			@blog_posts_batches << batch
		end
		
		# return @blog_posts_batches
		puts "@blog_posts_batches[0][0] #{@blog_posts_batches[0][0]}"
		puts "@blog_posts_batches[session[:batch_number]] #{@blog_posts_batches[session[:batch_number]]}"
		return @blog_posts_batches[session[:batch_number]]
	end
    end
	
end