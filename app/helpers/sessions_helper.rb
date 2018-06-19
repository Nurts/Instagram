module SessionsHelper

    def sign_in(user)
        session[:user_id] =  user.id
    end

    def signed_in?
        !current_user.nil?
    end

    def current_user
        if session[:user_id]
            @current_user ||= User.find(session[:user_id])
        end
    end

    def sign_out
        session[:user_id] = nil
        @current_user = nil
    end

end
