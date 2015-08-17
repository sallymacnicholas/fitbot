require 'rails_helper'

RSpec.describe Goal, type: :model do
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

  let!(:message) { Message.create(steps_needed: 1000,
                                  user_id: user.id)}

  it 'is valid' do
    expect(message).to be_valid
  end

  it 'is invalid without steps' do
    message.steps_needed = nil
    expect(message).to_not be_valid
  end

  it 'belongs to a user' do
    expect(message.user_id).to eq(user.id)
  end
end
