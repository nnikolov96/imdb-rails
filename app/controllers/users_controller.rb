class UsersController < ApplicationController
  before_action :set_user, only: %i[show destroy edit update]
  before_action :require_signin, except: %i[new create]
  before_action :require_correct_user, only: %i[edit update destroy]

  def index
    @users = User.all
  end

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: "Thanks for signing up!"
    else
      flash.now[:alert] = 'You couldnt sign up'
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'Account was updated'
    else
      flash.now[:alert] = 'We couldnt update your account'
      render :edit
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to movies_url, notice: "You're now signed out!"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.includes(:reviews).includes(:favorite_movies).find(params[:id])
  end
  def require_correct_user
    unless current_user?(@user)
      redirect_to root_path, alert: 'You are not authorized to do that!'
    end
  end

end
