class NotificationMessage
  include ActionView::Helpers

  def initialize
    @client = Twilio::REST::Client.new(ENV["twilio_sid"], ENV["twilio_token"])
  end

  def welcome
    @client.messages.create from: '7205063550', to: "+18622029173", body: "Heyyyyyyyyyyyyy!"
  end

  def send_message(current_user)
    @client.messages.create from: '7205063550', to: current_user.notification.number, body: current_user.goal.message
  end

  def steps_notification(current_user)
    if Time.now > current_user.goal.awake_time && Time.now < current_user.goal.sleep_time
      send_message(current_user)
    end
  end
end
