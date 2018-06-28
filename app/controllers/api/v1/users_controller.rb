class Api::V1::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    users = User.all
    render json: users, only: [:username, :id], status: :ok
  end

  def show
    user = User.find(params[:id])
    if user
      render json: user, only: [:username, :id], include: :posts, only: [:id, :likes_count]
    else
      render json: {status: :error}
    end
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user, only: [:username, :id, :email] 
    else
      render json: {errors: user.errors.full_messages}, status: :error
    end
  end


  private
  def user_params
    params.permit(:username, :password, :email)
  end
end
