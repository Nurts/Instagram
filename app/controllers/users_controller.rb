class UsersController < ApplicationController
    before_action :correct_user, only: [:edit, :update, :destroy]


    def index    
        @users = User.all
    end

    def show
        @user = User.find(params[:id])
    end

    def new
        redirect_to root_path if signed_in?
        @user = User.new
    end

    def create
        redirect_to root_path if signed_in?
        @user = User.new(user_params)
        if @user.save
            sign_in(@user)
            redirect_to @user
        else
            render :new
        end
    end

    def edit
    end

    def update
        if @user.update_attributes(user_params)

            redirect_to @user
        else
            render :edit
        end
        
    end

    def destroy
        sign_out
        @user.destroy
        redirect_to root_path
    end

    private
    
    def user_params 
        params.require(:user).permit(:username, :email, :password, :avatar)
    end

    def correct_user
        unless signed_in?
            redirect_to login_url
        else
            @user = User.find(params[:id])
            redirect_to user_path unless current_user?(@user)
        end
    end

end
