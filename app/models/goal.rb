class Goal < ActiveRecord::Base
  belongs_to :user

  def steps_needed
    steps_per_hour = steps/((sleep_time - awake_time)/3600).round(0)
    hours_since_awake = ((Time.now.beginning_of_hour.strftime("%I:%M%p").to_time - awake_time.strftime("%I:%M%p").to_time)/3600).round(0)
    steps_should_have_taken = steps_per_hour * (hours_since_awake + 1)
    @client = FitbitService.new(user)
    needed = steps_should_have_taken - @client.steps
    next_hour = (Time.now.end_of_hour + 1).strftime("%I:%M%p")
    "You need to get in #{needed} more steps before #{next_hour} to stay on track with your goal of #{steps} per day"
  end
end
