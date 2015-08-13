require 'rails_helper'

RSpec.describe Goal, type: :model do
  let(:user) { User.create(username: "sally", uid: '123456', token: '1111', secret:"12345", provider:"fitbot") }
  let(:goal) { Goal.create(steps: 10000, user_id: user.id)}

  before(:each) do
    user
  end

  it 'is valid' do
    expect(goal).to be_valid
  end

  it 'is invalid without steps' do
    goal.steps = nil
    expect(goal).to_not be_valid
  end

  it 'can calculate steps needed' do
    expect(goal.steps_needed).to eq()
  end
end
