class SessionsController < ApplicationController
    
    def new
    end
    
    def create
        login = params[:session][:login]
        user = login.include?("@") ? User.find_by_email(login) : User.find_by_username(login)

        if user && user.authenticate(params[:session][:password])
            sign_in user
            redirect_to user
        else
            flash[:error] = "Invalid username or password"
            render :new
        end
    end

    def destroy
        sign_out
        redirect_to login_path
    end


    
end
