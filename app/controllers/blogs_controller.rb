class BlogsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def show
    @user = User.find(params[:id])
    @blogs = @user.blogs.paginate(page: params[:page])
    redirect_to root_url and return unless @user.activated?
  end
  
  def create
    @blog = current_user.microposts.build(blog_params)
    @blog.image.attach(params[:blog][:image])
    if @blog.save
      flash[:success] = "The new blog post was created!"
      redirect_to root_url
    else
      @feed_items = current_user.feed.paginate(page: params[:page])
      render 'static_pages/home'
    end
  end

  def destroy
    @blog.destroy
    flash[:success] = "The blog post was deleted!"
    if request.referrer.nil? || request.referrer == microposts_url
      redirect_to root_url
    else
      redirect_back(fallback_location: root_url)
      
    end
  end

  private

    def blog_params
      params.require(:blog).permit(:content, :image)
    end

    def correct_user
      @blog = current_user.blogs.find_by(id: params[:id])
      redirect_to root_url if @blog.nil?
    end
end
