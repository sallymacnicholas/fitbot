class Goal < ActiveRecord::Base
  belongs_to :user

  def steps_needed
    steps_should_have_taken - client.steps
  end

  def steps_per_hour
    steps/((user.profile.sleep_time - user.profile.awake_time)/3600).round(0)
  end

  def hours_since_awake
    ((now_hour - awake_hour)/3600).round(0)
  end

  def steps_should_have_taken
    steps_per_hour * (hours_since_awake + 1)
  end

  def next_hour
    (Time.now.end_of_hour + 1).strftime("%I:%M%p")
  end

  def weekly_percent_to_goal
    ((client.steps.to_f/(steps * 7).to_f) * 100).to_i
  end

  def daily_percent_to_goal
    ((client.steps.to_f/steps.to_f) * 100).to_i
  end

  def client
    FitbitService.new(user)
  end

  def now_hour
    Time.now.beginning_of_hour.strftime("%I:%M%p").to_time
  end

  def awake_hour
    user.profile.awake_time.strftime("%I:%M%p").to_time
  end
end
