class SessionsController < ApplicationController

    before_action :ensure_login, only: [:destroy]
    def new
        render :new
    end

    def create
        @user = User.find_by_credentials(params[:user][:username], params[:user][:password])
        if @user && @user.save
            login(@user)
            redirect_to users_url
        else
            flash.now[:errors] = ["Invalid username or password"]
            render :new
        end
    end

    def destroy
        logout
        redirect_to new_session_url
    end
end