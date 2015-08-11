class Notification < ActiveRecord::Base
  belongs_to :user
  after_create :reminder

  def reminder
    @twilio_number = "+7205063550"
    @client = Twilio::REST::Client.new(ENV["twilio_sid"], ENV["twilio_token"])
  end
end
