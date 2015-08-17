require 'rails_helper'

RSpec.describe Goal, type: :model do
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
  it 'tests goals stuff' do
    VCR.use_cassette 'goals' do
      response = FitbitService.new(user)
      client ||= Fitgem::Client.new(
      :consumer_key => ENV["consumer_key"],
      :consumer_secret => ENV["consumer_secret"],
      :token => user.token,
      :secret => user.secret,
      :user_id => user.uid)
      allow_any_instance_of(Goal).to receive(:client).and_return(client)
      allow_any_instance_of(Goal).to receive(:next_hour).and_return("5:00PM")
      allow_any_instance_of(Goal).to receive(:hours_since_awake).and_return(8)

      # expect(response.steps).to eq(11)

      # expect(goal.hours_since_awake).to eq(13)
      # expect(goal.steps_should_have_taken).to eq(8232)
      # expect(goal.next_hour).to eq("05:00PM")
      # expect(goal.now_hour).to eq("2015-08-17 16:00:00.000000000 -0600")
      # expect(goal.steps_needed).to eq(4687)
    end
  end

  it 'is valid' do
    expect(goal).to be_valid
  end

  it 'is invalid without steps' do
    goal.steps = nil
    expect(goal).to_not be_valid
  end

  it 'belongs to a user' do
    expect(goal.user_id).to eq(user.id)
  end
end
