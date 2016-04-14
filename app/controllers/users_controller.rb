class UsersController < ApplicationController
  # def index
  # end
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def destroy #after creating login make sure destroy redirects to new login
    User.find(params[:id]).destroy
    redirect_to action: "index"
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to action: "show", id: @user.id
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to login_new_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :email, :password, :password_confirmation)
  end
end
