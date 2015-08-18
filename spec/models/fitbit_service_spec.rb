require 'rails_helper'

RSpec.describe FitbitService, type: :model do
  let!(:user) { User.create(username: "sally",
    uid: ENV["uid"],
    token: ENV["token"],
    secret: ENV["secret"],
    provider:"fitbit") }

  it 'can do something' do
    stub_omniauth_user
    VCR.use_cassette 'fitbit-calls' do
      response = FitbitService.new(user)
      client ||= Fitgem::Client.new(
        :consumer_key => ENV["consumer_key"],
        :consumer_secret => ENV["consumer_secret"],
        :token => user.token,
        :secret => user.secret,
        :user_id => user.uid)
      allow_any_instance_of(FitbitService).to receive(:summary).and_return(client.activities_on_date('today')["summary"])
      allow_any_instance_of(FitbitService).to receive(:user_info).and_return(client.user_info["user"])
      expect(response.steps).to eq(3932)
      expect(response.average_daily_steps).to eq(2040)
      expect(response.calories).to eq(1561)
      expect(response.floors).to eq(5)
      expect(response.miles).to eq(1.53)
      expect(response.age).to eq(29)
      expect(response.dob).to eq("1985-12-21")
      expect(response.gender).to eq("FEMALE")
      expect(response.avatar).to eq("https://d6y8zfzc2qfsl.cloudfront.net/0441DA2F-F541-BC10-96F4-2935A14560A7_profile_100_square.jpg")
      expect(response.display_name).to eq("sally")
      expect(response.badges.first["description"]).to eq("10,000 steps in a day")
    end
  end
end
