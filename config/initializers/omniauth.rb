Rails.application.config.middleware.use OmniAuth::Builder do
  provider :fitbit, ENV['CLIENT_ID'], ENV['CLIENT_SECRET']
end
