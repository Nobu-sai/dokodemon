class StaticPagesController < ApplicationController

  def home
     
    @blog_posts_feed = blog_posts_feed(params[:direction])       
    
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
