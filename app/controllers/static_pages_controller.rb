
class StaticPagesController < ApplicationController
	include SessionTrackBatchNumberHelper


  def home    
    
    # @total_batches = calculate_total_batches(batch_size)
    # @blog_posts_feed = fetch_blog_posts_as_a_batch(params[:direction], params[:clicked_page], batch_size: batch_size) 
    @blog_posts_feed = BlogPostsFeedQuery.new.fetch_blog_posts_as_a_batch(current_user: current_user, logged_in: logged_in?, batch_number: get_batch_number)
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

  private 
    def get_batch_number
      batch_size = 100
      batch_number = track_batch_number(params[:direction], params[:clicked_page], batch_size)
    
    end

end
