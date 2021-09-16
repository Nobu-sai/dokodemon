class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @blog  = current_user.blogs.build
      # @feed_items = current_user.feed.paginate(page: params[:page])
      @feed_items = blog_posts_feed.paginate(page: params[:page])
    end
  end

  def help
  end
  
  def about 
  end
  
  def contact
  end

end
