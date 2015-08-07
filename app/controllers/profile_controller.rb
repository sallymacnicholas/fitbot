class ProfileController < ApplicationController
  def show
    @goal = Goal.new
    @client = FitbitService.new(current_user)
  end
end
