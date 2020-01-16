class ApplicationController < ActionController::Base
    protect_from_forgery

    protected
    def current_user
        User.find(session[:user_id]) if session[:user_id]
    end
end