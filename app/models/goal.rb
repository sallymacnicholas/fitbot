class Goal < ActiveRecord::Base
  belongs_to :user

  def steps_needed
    steps_should_have_taken - FitbitService.new(user).steps
  end

  def formatted_awake_time
    awake_time.strftime("%I:%M%p")
  end

  def formatted_sleep_time
    sleep_time.strftime("%I:%M%p")
  end

  def steps_per_hour
    steps/((sleep_time - awake_time)/3600).round(0)
  end

  def hours_since_awake
    ((Time.now.beginning_of_hour.strftime("%I:%M%p").to_time - awake_time.strftime("%I:%M%p").to_time)/3600).round(0)
  end

  def steps_should_have_taken
    steps_per_hour * (hours_since_awake + 1)
  end

  def next_hour
    (Time.now.end_of_hour + 1).strftime("%I:%M%p")
  end

  def message
    "You need to get in #{steps_needed} more steps before #{next_hour} to stay on track with your goal of #{steps} per day"
  end
end
