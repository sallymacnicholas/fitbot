require 'rails_helper'

RSpec.describe Goal, type: :model do
  let(:user) { User.create(username: "sally", uid: '123456', token: '1111', secret:"12345", provider:"fitbot") }
  let(:profile) { Profile.create(awake_time:"04:00", sleep_time:"21:00", user_id: user.id)}

  before(:each) do
    user
    profile
  end

  it 'is valid' do
    expect(profile).to be_valid
  end

  it 'is invalid without awake_time' do
    profile.awake_time = nil
    expect(profile).to_not be_valid
  end

  it 'can format awake time' do
    expect(profile.formatted_awake_time).to eq("04:00AM")
  end

  it 'can format sleep time' do
    expect(profile.formatted_sleep_time).to eq("09:00PM")
  end

  it 'can give awake times' do
    expect(profile.awake_times).to eq("04:00AM - 09:00PM")
  end

  it 'belongs to a user' do
    expect(profile.user_id).to eq(user.id)
  end

end
