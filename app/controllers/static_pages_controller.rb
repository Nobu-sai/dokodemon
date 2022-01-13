class StaticPagesController < ApplicationController

  def home
    track_batch_number_session(params[:direction], params[:clicked_page])
    @blog_posts_feed = fetch_blog_posts_as_a_batch()       
    
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
