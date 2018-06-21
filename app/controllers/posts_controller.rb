class PostsController < ApplicationController
    before_action :check, only: :destroy

    def create
        @post = current_user.posts.build(post_params)
        if @post.save
            redirect_to root_path
        else
            render "pages#new"
        end
    end
    
    def destroy
        Post.find(params[:id]).destroy
        redirect_to root_path
    end

    private
    def post_params
        params.require(:post).permit(:body, :image)
    end

    def check
        unless current_user?(Post.find(params[:id]).user)
            flash[:danger] = "Not your post!"
            redirect_to root_path
        end
    end
end
