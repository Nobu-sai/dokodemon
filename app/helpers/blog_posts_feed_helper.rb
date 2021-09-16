module BlogPostsFeedHelper
    
  # Fetch the right Blog Posts 
  # => Becomes the Array of Blog Posts diaplayed in the a proto-feed View (app/views/shared/_blog_posts_feed.html.erb).      
    def blog_posts_feed

	following_ids = current_user.set_following_ids_query
		
	# Get the Blog Posts based on the gotten ids		
		# - The posts for the users the OGGED IN user is FOLLOWING 
		# - The posts for the LOGGED IN user ONESELF
		# Src
		# - evernote:///view/180370944/s350/19623e87-a598-3cc0-6e19-144553d84ec2/77812575-71c1-4561-9362-9c31a7a32180
		Blog.where("user_id IN (#{following_ids})
			OR user_id = :current_user_id", current_user_id: "#{current_user.id}")
			.includes(:user, image_attachment: :blob)
				# = Eager Loading
					# - For Active Storage n + 1 Query Problem 	
						# evernote:///view/180370944/s350/1ab665fe-df8c-1211-4eac-6c4571986d4c/77812575-71c1-4561-9362-9c31a7a32180
	# IF NOT
		# All in reverse chronological order (latest at top)

    end
	
end