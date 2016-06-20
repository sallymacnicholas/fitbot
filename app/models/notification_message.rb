class NotificationMessage
  include ActionView::Helpers

  def initialize
    @client = Twilio::REST::Client.new(ENV["twilio_sid"], ENV["twilio_token"])
  end

  def welcome(current_user)
    @client.messages.create from: '7205063550', to: current_user.notification.number, body: welcome_message(current_user)
  end

  def notification(current_user)
    @client.messages.create from: '7205063550', to: current_user.notification.number, body: notification_message(current_user.goal)
  end
  

  def steps_notification(current_user)
    notification(current_user)
    Message.create steps_needed: current_user.goal.steps_needed, user_id: current_user.id
  end

  def welcome_message(user)
    "Welcome, #{user.username} to Fitbot! Your notifications start now!"
  end

  def notification_message(current_user_goals)
    "You need to get in #{current_user_goals.steps_needed} more steps before #{current_user_goals.next_hour} to stay on track with your goal of #{current_user_goals.steps} per day"
  end
end
