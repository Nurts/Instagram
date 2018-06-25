class SessionsController < ApplicationController
    
    def new
    end
    
    def create
        login = params[:session][:login].downcase
        user = login.include?("@") ? User.find_by_email(login) : User.find_by_username(login)

        if user && user.authenticate(params[:session][:password])
            sign_in user
            remember user
            redirect_to user
        else
            flash[:danger] = "Invalid username, email or password"
            render :new
        end
    end

    def destroy 
        sign_out if signed_in?
        redirect_to root_path
    end
end
