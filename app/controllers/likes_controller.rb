class LikesController < ApplicationController
    
    def create
        @post_id = params[:like][:post_id]
        Like.new(post_id: @post_id, user_id: current_user.id).save
        @count = Post.find(@post_id).likes.count
        respond_to do |format|
            format.js{}
        end
    end

    def destroy
        @post_id = params[:like][:post_id]
        Like.where(post_id: @post_id, user_id: current_user.id).first.destroy!
        @count = Post.find(@post_id).likes.count
        respond_to do |format|
            format.js{}
        end
    end


end
