class StaticPagesController < ApplicationController
  include SessionTrackBatchNumberHelper 
  include CalculateTotalBatchesHelper
  include SessionDefineBatchSizeHelper 
  include CalculateTotalBatchesHelper

  def home
    define_batch_size
    track_batch_number(params[:direction], params[:clicked_page])
    @total_batches = calculate_total_batches
    @blog_posts_feed = fetch_blog_posts_as_a_batch      
    
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
