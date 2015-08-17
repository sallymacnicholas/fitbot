require 'rails_helper'

RSpec.describe Notification, type: :model do
  let!(:user) { User.create(username: "sally",
                           uid: '123456',
                           token: '1111',
                           secret:"12345",
                           provider:"fitbot") }

  let!(:goal) { Goal.create(steps: 10000,
                            user_id: user.id)}

  let!(:profile) { Profile.create(awake_time:"04:00",
                                 sleep_time:"21:00",
                                 user_id: user.id)}

  let!(:notification) { Notification.create number:"7209364687",
                        user_id: user.id}

  it 'is valid' do
    expect(notification).to be_valid
  end

  it 'belongs to a user' do
    expect(notification.user_id).to eq(user.id)
  end

end
