class BlogsController < ApplicationController
  include SessionTrackBatchNumberService  

  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def index    
    @blogs = Blog.all.paginate(page: params[:page])   
  end
  
  def create
    @blog = current_user.blogs.build(blog_params)    
    @blog.image.attach(params[:blog][:image])
    
    respond_to do |format|
    
      if @blog.save

        flash[:success] = "The new blog post was created!"           

        format.html { redirect_to controller: session[:current_controller], action: session[:current_action] }           
          # - String Path can NOT be used
      else      

        batch_size = 100        
        @blog_posts_feed = BlogPostsFeedQuery.new.fetch_blog_posts_as_a_batch(current_user: current_user, batch_size: batch_size, batch_number: nil)
          # - Feed is retuired 
            # P
              # - On failed submission        
        format.html { render "#{session[:string_path]}", status: 400 }       
 
      end
        
    end

    
  end

  def show
    @blog = Blog.find(params[:id])
    @user = User.find(@blog.user.id)
  end
  
  def destroy
    @blog.destroy
    flash[:success] = "The blog post was deleted!"
    if request.referrer.nil? || request.referrer == blogs_url
      redirect_to root_url
    else
      redirect_back(fallback_location: root_url)
      
    end
  end

  private

    def blog_params
      params.require(:blog).permit(:title, :text, :image)
    end

    def correct_user
      @blog = current_user.blogs.find_by(id: params[:id])
      redirect_to root_url if @blog.nil?
    end
end
