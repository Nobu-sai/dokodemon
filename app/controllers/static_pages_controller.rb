class StaticPagesController < ApplicationController

  def home
    # Success
      # @blog_posts_feed = blog_posts_feed.paginate(page: params[:page]) 
    
    # Try 
    # => Use an Array of Batches
    @blog_posts_batches = blog_posts_feed 
    # @blog_posts_batches = blog_posts_feed.paginate(page: params[:page]) 

    # @blog_posts_feed.paginate(page: params[:page])
    puts "@blog_posts_batches #{@blog_posts_batches}"
    puts "@blog_posts_batches.class #{@blog_posts_batches.class}"
    puts "@blog_posts_batches.first #{@blog_posts_batches.first}"
    puts "@blog_posts_batches[0] #{@blog_posts_batches[0]}"
    @blog_posts_batches.each do | batch |  
    # # blog_posts_batches.each do | batch | 
    # #   batch.inspect
      puts "batch: #{batch}"
      puts "batch Class: #{batch.class}"
      # puts "batch.first #{batch.first}"
        # => Undefined method "first"
      @blog_posts_feed = batch.paginate(page: params[:page])

    end
    
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
