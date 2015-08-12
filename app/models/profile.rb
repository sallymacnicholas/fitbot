class Profile < ActiveRecord::Base
  belongs_to :user

  def formatted_awake_time
    awake_time.strftime("%I:%M%p")
  end

  def formatted_sleep_time
    sleep_time.strftime("%I:%M%p")
  end
end
