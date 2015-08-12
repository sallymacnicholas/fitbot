desc "This task is called by the Heroku scheduler add-on"
task :send_notification => :environment do
  puts "something"
  User.all.each do |user|
    NotificationMessage.new.steps_notification(user)
  end
  puts "done. hoooorayyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy"
end
