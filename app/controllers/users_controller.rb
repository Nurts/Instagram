class UsersController < ApplicationController
    before_action :correct_user, only: [:edit, :update, :destroy]


    def index    
        @users = User.all
    end

    def show
        @user = User.find(params[:id])
        @post = Post.new if signed_in?
    end

    def new
        redirect_to root_path if signed_in?
        @user = User.new
    end

    def create
        redirect_to root_path if signed_in?
        @user = User.new(user_params)
        if @user.save
            UserMailer.account_activation(@user).deliver_now
            sign_in(@user)
            redirect_to @user
            flash[:success] = "Signed up successfully"
        else
            render :new
        end
    end

    def edit
    end

    def update
        if @user.update_attributes(user_params)
            flash[:success] = "Changes were successfully saved"
            redirect_to @user
        else
            render :edit
        end
        
    end

    def destroy
        sign_out
        @user.destroy
        flash[:success] = "User was Deleted Successfully"
        redirect_to root_path
    end

    private
    
    def user_params 
        params.require(:user).permit(:username, :email, :password, :avatar)
    end

    def correct_user
        unless signed_in?
            flash[:danger] = "Please sign in first"
            redirect_to login_url
        else
            @user = User.find(params[:id])
            unless current_user?(@user)
                flash[:danger] = "You are not allowed to edit others"
                redirect_to user_path 
            end
        end
    end

end
