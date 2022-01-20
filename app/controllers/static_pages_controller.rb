

class StaticPagesController < ApplicationController


  def home    
    batch_size = 100
    # @total_batches = calculate_total_batches(batch_size)
    # @blog_posts_feed = fetch_blog_posts_as_a_batch(params[:direction], params[:clicked_page], batch_size: batch_size) 
    @blog_posts_feed = FetchBlogPostsFeedQuery.new.fetch_blog_posts_as_a_batch(params[:direction], params[:clicked_page], batch_size: batch_size)
    # @blog_posts_feed = FetchBlogPostsFeedQuery.new
    # @blog_posts_feed.fetch_blog_posts_as_a_batch(params[:direction], params[:clicked_page], batch_size: batch_size)
    
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
