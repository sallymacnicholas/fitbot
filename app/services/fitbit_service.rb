class FitbitService
  attr_reader :client

  def initialize(user)
    @client ||= Fitgem::Client.new(
      :consumer_key => ENV["consumer_key"],
      :consumer_secret => ENV["consumer_secret"],
      :token => user.token,
      :secret => user.secret,
      :user_id => user.uid
    )
  end

  def steps
    client.activities_on_date(Time.now.strftime("%Y-%m-%d"))["summary"]["steps"]
  end

  def calories
    client.activities_on_date(Time.now.strftime("%Y-%m-%d"))["summary"]["caloriesOut"]
  end

  def floors
    client.activities_on_date('today')["summary"]["floors"]
  end

  def miles
    client.activities_on_date('today')["summary"]["distances"].first["distance"]
  end

  def age
    client.user_info["user"]["age"]
  end

  def average_daily_steps
    client.user_info["user"]["averageDailySteps"]
  end

  def gender
    client.user_info["user"]["gender"]
  end

  def avatar
    client.user_info["user"]["avatar"]
  end

  def display_name
    client.user_info["user"]["displayName"]
  end

  def dob
    client.user_info["user"]["dateOfBirth"]
  end
end
