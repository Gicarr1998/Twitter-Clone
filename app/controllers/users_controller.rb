class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :create]
  before_action :correct_user, only: [:edit, :update]
  before_action :set_user, only: [:edit, :update, :show]

  def index
    @user = User.paginate(page: params[:page], per_page: 10)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Successfully Added"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def show
    @micropost = @user.microposts.build
    @microposts = @user.microposts.paginate(page: params[:page], per_page: 12)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Successfully Updated"
      redirect_to root_url
    else
      render 'edit'
    end
end

def destroy
  if @user.destroy
    flash[:success] = "Successfully Deleted"
    redirect_to root_url
  else
    flash[:danger] = "Delete Failed"
    redirect_to root_url
  end
end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def correct_user
    @user = User.find(params[:id])
    if @user != current_user
      flash[:danger] = "You are not authorized"
      redirect_to root_url
    end
  end
end
