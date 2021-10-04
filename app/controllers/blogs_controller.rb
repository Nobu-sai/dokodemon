class BlogsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def index    
    @blogs = Blog.all.paginate(page: params[:page])   
  end
  
  # def new
  #   @blog = Blog.new
  #   render 'static_pages/home'
  # end

  def create
    @blog = current_user.blogs.build(blog_params)
    # @blog = Blog.create(blog_params)

    @blog.image.attach(params[:blog][:image])
    respond_to do |format|
      if @blog.save
        flash[:success] = "The new blog post was created!"
        # redirect_to root_url
        # respond_to do |format|
          format.html { redirect_to root_url }
          format.json
        # end
      else      
        @blog_posts_feed = blog_posts_feed.paginate(page: params[:page])
          # P
          # - On failed submission
        @back_url = session[:my_previous_url] = URI(request.referer || '').path
        # redirect_to root_url()
        # redirect_to root_path(@user, :messages => @user.errors)
        # render 'static_pages/home'
        # render :new
        # redirect_to blog:new
        respond_to do |format|
          format.html { render 'static_pages/home' }
          format.json
        end
        # render json: { errors: @blog },
        # status: :unprocessable_entity
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
