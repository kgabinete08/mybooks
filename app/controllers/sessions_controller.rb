class SessionsController < ApplicationController

  def new; end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "You have logged in successfully!"
      redirect_to home_path
    else
      flash[:danger] = "Invalid email and password."
      redirect_to sign_in_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'You have signed out successfully!'
    redirect_to root_path
  end
end