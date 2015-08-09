class DashboardController < ApplicationController
  def index
    @client = FitbitService.new(current_user)
    @steps_needed_to_hit_goal = current_user.goal.steps_needed
  end
end
