class SessionsController < ApplicationController
  def new
    @user = User.new
    render :new
  end
  
  def create
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password])
    if @user.nil?
      flash.now[:errors] = "Invalid Username/Password Combination"
      render :new
    else
      login_user!(@user)
      redirect_to "/"
    end
  end
  
  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    redirect_to new_session_url
  end
  
  
end
