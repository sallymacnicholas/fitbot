class DashboardController < ApplicationController
  def index
    @notification = current_user.notification
  end
end
