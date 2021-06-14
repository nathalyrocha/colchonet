class UsersController < ApplicationController
  before_action :require_no_authentication, only: [:new, :create]
  before_action :can_change, only: [:edit, :update]

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)

    if @user.save
      SignupMailer.confirm_email(@user).deliver

      redirect_to @user, notice: 'Successfully registered!'
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to @user, notice: 'Successfully updated!'
    else
      render :update
    end
  end

  private

  def can_change
    unless user_signed_in?  && current_user == user
      redirect_to user_path(params[:id])
    end
  end

  def user
    @user ||= User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:full_name, :email, :location, :password, :password_confirmation, :bio)
  end
end
