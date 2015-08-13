class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user, :client, :notification_number, :user_awake_time

  def client
    @client = FitbitService.new(current_user)
  end

  def notification_number
    current_user.notification && current_user.notification.number
  end

  def user_awake_time
    if current_user.profile
      "#{current_user.profile.formatted_awake_time} - #{current_user.profile.formatted_sleep_time}"
    end
  end
end
