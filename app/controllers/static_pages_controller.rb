class StaticPagesController < ApplicationController

  def home

    @blog_posts_feed = fetch_blog_posts_as_a_batch(params[:direction], params[:clicked_page] ? params[:clicked_page] : false)       
    
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
