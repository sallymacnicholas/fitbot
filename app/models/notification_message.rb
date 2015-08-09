class NotificationMessage
  include ActionView::Helpers

  def initialize
    @client = Twilio::REST::Client.new(ENV["twilio_sid"], ENV["twilio_token"])
  end

  def welcome
    @client.messages.create from: '7205063550', to: "+18622029173", body: "Heyyyyyyyyyyyyy!"
  end

  def steps_notification(current_user)
    @client.messages.create from: '7205063550', to: "+17209364687", body: current_user.goal.steps_needed
  end
end
