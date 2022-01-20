
class StaticPagesController < ApplicationController


  def home    
    batch_size = 100
    @blog_posts_feed = BlogPostsFeedQuery.new(direction: params[:direction], clicked_page: params[:clicked_page], batch_size: batch_size).fetch_blog_posts_as_a_batch
    
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
