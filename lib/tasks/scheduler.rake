desc "This task is called by the Heroku scheduler add-on"
task :send_notification => :environment do
  User.all.each do |user|
    if user.notification
      if Time.now.hour.between?(user.profile.awake_time.hour, user.profile.sleep_time.hour)
        NotificationMessage.new.steps_notification(user)
        puts "Notification message sent at #{Time.now}"
      else
        puts "Notification not sent. Time is not during user awake hours."
      end
    else
      puts "User isn't set up for notification"
    end
  end
end
