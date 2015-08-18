require 'rails_helper'

RSpec.describe Notification, type: :model do
  let!(:user) { User.create(username: "sally",
    uid: ENV["uid"],
    token: ENV["token"],
    secret: ENV["secret"],
    provider:"fitbit") }

  let!(:goal) { Goal.create(steps: 10000,
    user_id: user.id)}

  let!(:profile) { Profile.create(awake_time:"04:00",
    sleep_time:"21:00",
    user_id: user.id)}

  let!(:notification) { Notification.create(number: "7209364687", user_id: user.id)}

  it 'does something' do
    expect(Message.all.count).to eq(0)
    NotificationMessage.new.steps_notification(user)
    expect(Message.all.count).to eq(1)
  end
end
