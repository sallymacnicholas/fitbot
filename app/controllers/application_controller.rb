class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user, :client, :notification_number, :awake_and_goals

  def client
    @client = FitbitService.new(current_user)
  end

  def notification_number
    current_user.notification && current_user.notification.number
  end

  def awake_and_goals
    current_user.profile && current_user.goal
  end
end
