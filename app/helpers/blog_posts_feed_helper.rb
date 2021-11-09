module BlogPostsFeedHelper
	include SessionsHelper
	
  # Fetch the right Blog Posts 
  # => Becomes the Array of Blog Posts diaplayed in the a proto-feed View (app/views/shared/_blog_posts_feed.html.erb).      
    def blog_posts_feed

	# IF the user IS logged in
	if logged_in?
		# What to do
		# - The posts for the users the OGGED IN user is FOLLOWING 
		# - The posts for the LOGGED IN user ONESELF
		# Src
		# - evernote:///view/180370944/s350/19623e87-a598-3cc0-6e19-144553d84ec2/77812575-71c1-4561-9362-9c31a7a32180
		following_ids = current_user.set_following_ids_query
			
		# Get the Blog Posts based on the gotten ids		
		# @blog_posts_feed =
		# @blog_posts_feed = 
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
		# @blog_posts_feed = 
		# @blog_posts_feed = 
		# Blog.all.includes(:user, image_attachment: :blob)
		# Blog.find_in_batches.includes(:user, image_attachment: :blob)
		# Blog.find_each.includes(:user, image_attachment: :blob)
		# Blog.in_batches.includes(:user, image_attachment: :blob)
		
		# Case.1
		# Blog.includes(:user, image_attachment: :blob)
		# Blog.includes(:user, image_attachment: :blob).all
		# Blog.includes(:user, image_attachment: :blob).find_each

		# Blog.includes(:user, image_attachment: :blob).find_in_batches 
		Blog.includes(:user, image_attachment: :blob).find_in_batches.first 
		# Blog.includes(:user, image_attachment: :blob).find_in_batches do |blog_posts_feed|
		# 	return blog_posts_feed
		# end
		# Blog.includes(:user, image_attachment: :blob).find_in_batches.each_with_object()
		# Blog.includes(:user, image_attachment: :blob).find_in_batches.each_record
		# Blog.includes(:user, image_attachment: :blob).find_in_batches.each
		# Blog.includes(:user, image_attachment: :blob).find_in_batches.first
		
		# Blog.includes(:user, image_attachment: :blob).in_batches
		# Blog.includes(:user, image_attachment: :blob).in_batches.each_record
		# Blog.includes(:user, image_attachment: :blob).in_batches.first
		# Blog.in_batches.first.includes(:user, image_attachment: :blob)
	end
    end
	
end