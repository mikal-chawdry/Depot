class ApplicationController < ActionController::Base
  before_action :authorize
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id] #find_by returns nil if no object is found so you dond need the if statement
  end
  
  def authorize
    unless current_user
      redirect_to login_url, notice: "Please log in to view that page"
    end
  end

end
