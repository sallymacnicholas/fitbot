class FitbitService
  attr_reader :client

  def initialize
    @client = Hurley::Client.new('')
  end
end
