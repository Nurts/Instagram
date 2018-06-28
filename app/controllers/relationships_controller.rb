class RelationshipsController < ApplicationController
  before_action :signed_in?


  def create
    followed_id = params[:follow][:followed_id]
    @user = User.find(followed_id)
    current_user.follow(@user)
    respond_to do |format|
      format.js{}
    end
  end

  def destroy
    followed_id = params[:follow][:followed_id]
    @user = User.find(followed_id)
    current_user.unfollow(@user)
    respond_to do |format|
      format.js{}
    end
  end
end
