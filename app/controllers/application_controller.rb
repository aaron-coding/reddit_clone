class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :ensure_logged_in, :current_user, :logged_in?
  
  
  def login_user!(user)
    session[:session_token] = user.reset_session_token!
  end
  
  def current_user
    User.find_by_session_token(session[:session_token])
  end
  
  def logged_in?
    !!current_user
  end
  
  private
  def ensure_logged_in
    redirect_to new_session_url unless logged_in?
  end
end
