class Profile < ActiveRecord::Base
  validates :awake_time, presence: true
  belongs_to :user

  def formatted_awake_time
    awake_time.strftime("%I:%M%p")
  end

  def formatted_sleep_time
    sleep_time.strftime("%I:%M%p")
  end

  def awake_times
    "#{formatted_awake_time} - #{formatted_sleep_time}"
  end
end
