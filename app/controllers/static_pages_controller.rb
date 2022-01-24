
class StaticPagesController < ApplicationController
  include SessionTrackBatchNumberService  

  def home    
    
    @batch_size = 100
   
    @blog_posts_feed = BlogPostsFeedQuery.new.fetch_blog_posts_as_a_batch(current_user: current_user, batch_size: @batch_size, batch_number: track_batch_number(params[:batch_number]))
    
    if logged_in?
      @blog  = current_user.blogs.build      
    end

  end

  def help
  end
  
  def about 
  end
  
  def contact
  end


end
