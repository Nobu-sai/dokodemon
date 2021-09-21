class StaticPagesController < ApplicationController

  def home
    
    @feed_items = blog_posts_feed.paginate(page: params[:page])

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
