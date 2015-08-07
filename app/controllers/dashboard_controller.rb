class DashboardController < ApplicationController
  def index
    @client = FitbitService.new(current_user)
  end
end
