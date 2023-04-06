class SessionsController < ApplicationController
    before_action :require_auth_false, only: %i[new create]
    before_action :require_auth_true, only: %i[destroy]
    def new
    end

    def create
        user =  User.find_by email: params[:email]
        if user&.authenticate(params[:password])
            sign_in(user)
            remember(user) if params[:remember_me] == '1'
            flash[:success] = "Welcome to the app, #{current_user.name_or_email}!"
            redirect_to root_path
        else
            flash.now[:warning] = "Incorrect email and/or password!"
            render :new
        end
    end

    def destroy
        sign_out
        flash[:success] = "See you later!"
        redirect_to root_path
    end
  end