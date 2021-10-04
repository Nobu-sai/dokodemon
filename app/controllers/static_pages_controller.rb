class StaticPagesController < ApplicationController

  def home
    
    @blog_posts_feed = blog_posts_feed.paginate(page: params[:page])
    @back_url = session[:my_previous_url] = URI(request.referer || '').path
    
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
