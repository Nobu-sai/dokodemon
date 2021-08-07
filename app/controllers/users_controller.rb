class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])

  end


  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
      # : Use Strong Parameters
      #   P
      #   : evernote:///view/180370944/s350/f853988c-9e8b-4f0a-63e3-4702861b2711/77812575-71c1-4561-9362-9c31a7a32180
    if @user.save
      reset_session
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  
  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
  

end

