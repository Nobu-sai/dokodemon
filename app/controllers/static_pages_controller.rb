
class StaticPagesController < ApplicationController
  include SessionTrackBatchNumberService  
  
  before_action :session_store_path

  def home    

    @batch_size = 100
    # puts "## StaticPagesController/home"

    @blog_posts_batch = BlogPostsFeedQuery.new.fetch_blog_posts_as_a_batch(current_user: current_user, batch_size: @batch_size, batch_number: track_batch_number(params[:page]))

    # puts "## StaticPagesController/home/after @blog_posts_batc "
 
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
