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

require_relative 'application_query'

class FetchBlogsPostsFeedQuery < ApplicationQuery
	
	include SessionsHelper
	include SessionTrackBatchNumberHelper
	include CalculateTotalBatchesHelper
	
	def initialize(blogs = Blog.all)
		@blogs = blogs
	end

    def fetch_blog_posts_as_a_batch(direction = nil, clicked_page = nil, batch_size:)

	calculate_total_batches(batch_size)
	track_batch_number(direction, clicked_page, batch_size)
	@blog_posts_batches = []

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
		
		blog_posts_batches = @blog.includes(:user, image_attachment: :blob).in_batches(of: batch_size)		
		blog_posts_batches.each do | batch |
			@blog_posts_batches << batch
		end
		return @blog_posts_batches[session[:batch_number]]
	end
    end

end