# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!
end

def stub_omniauth_user
  OmniAuth.config.test_mode = true
  OmniAuth.config.mock_auth[:fitbit] = OmniAuth::AuthHash.new({
      provider: 'fitbit',
      uid: '123456',
      info: {
        full_name: 'sally'
      },
      extra: {
        access_token: {params: {oauth_token_secret: "111", oauth_token: "222"}}}
    })
end



