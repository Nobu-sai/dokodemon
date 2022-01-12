class StaticPagesController < ApplicationController

  def home
    
    # Try 
    # => Use an Array of Batches
    @blog_posts_batches = blog_posts_feed 
    # # @blog_posts_batches = blog_posts_feed.paginate(page: params[:page]) 

    # @blog_posts_feed.paginate(page: params[:page])
    puts "Blog Records amount #{Blog.count}"
    # puts "@blog_posts_batches #{@blog_posts_batches}"
    puts "@blog_posts_batches.count #{@blog_posts_batches.count}"
    puts "@blog_posts_batches.class #{@blog_posts_batches.class}"
    puts "@blog_posts_batches.first #{@blog_posts_batches.first}"
    puts "@blog_posts_batches[0] #{@blog_posts_batches[0]}"
    puts "@blog_posts_batches[0].count #{@blog_posts_batches[0].count}"
    @blog_posts_batches.each do | batch |  
    # # blog_posts_batches.each do | batch | 
    # #   batch.inspect
      # puts "batch: #{batch}"
      puts "batch.class: #{batch.class}"
      puts "batch.count: #{batch.count}"
      # puts "batch.first #{batch.first.count}"
        # => NoMethodError (undefined method `count' for #<Blog:0x00007fee78324718>):
      # puts "batch.second #{batch.second.count}"
        # => NoMethodError (undefined method `count' for #<Blog:0x00007fee78324718>):
      puts "batch[0] #{batch[0]}"
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
