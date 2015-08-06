class GoalsController < ApplicationController
  def new

  end

  def create
    @goal = Goal.create(goal_params)
    @goal.user_id = current_user.id
    @goal.save
    redirect_to profile_path(current_user)
  end

  private

  def goal_params
    params.require(:goal).permit(:awake_time, :sleep_time, :steps)
  end
end
