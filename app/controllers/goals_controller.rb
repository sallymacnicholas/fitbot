class GoalsController < ApplicationController
  def index
    if current_user.goal
      @goal = current_user.goal
    else
      @goal = Goal.new
    end
  end

  def new
  end

  def create
    @goal = Goal.create(goal_params)
    @goal.user_id = current_user.id
    @goal.save
    redirect_to goals_path
  end

  def update
    @goal = Goal.find(params[:id])
    @goal.update(goal_params)
    redirect_to goals_path
  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy
    redirect_to goals_path
  end

  private

  def goal_params
    params.require(:goal).permit(:awake_time, :sleep_time, :steps)
  end
end
