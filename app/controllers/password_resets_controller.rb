class PasswordResetsController < ApplicationController
  before_action :get_valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "Email sent with password reset instructions"
      redirect_to root_url
    else
      flash[:danger] = "Email address not found"
      redirect_to new_password_reset_path
    end
  end

  def edit
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, "can't be empty")
      render :edit
    elsif @user.update_attributes(user_params)
      sign_in @user
      @user.update_attribute(:reset_digest, nil)
      flash[:success] = "Password has been reset"
      redirect_to root_path
    else 
      render :edit
    end
  end
  

  private
  
  def user_params
    params.require(:user).permit(:password)
  end

  def get_valid_user
    @user = User.find_by(email: params[:email])
    redirect_to root_url unless (@user && @user.authenticated?(:reset, params[:id])) #need to add @user.activated? in production
  end

  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = "Password reset has expired"
      redirect_to new_password_reset_url
    end
  end
end
