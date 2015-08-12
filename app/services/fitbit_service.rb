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

  def summary
    client.activities_on_date('today')["summary"]
  end

  def steps
    summary["steps"]
  end

  def calories
    summary["caloriesOut"]
  end

  def floors
    summary["floors"]
  end

  def miles
    summary["distances"].first["distance"]
  end

  def age
    user_info["age"]
  end

  def average_daily_steps
    user_info["averageDailySteps"]
  end

  def gender
    user_info["gender"]
  end

  def avatar
    user_info["avatar"]
  end

  def display_name
    user_info["displayName"]
  end

  def dob
    user_info["dateOfBirth"]
  end

  def badges
    user_info["topBadges"]
  end

  def user_info
    client.user_info["user"]
  end
end
