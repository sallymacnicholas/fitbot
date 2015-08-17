require 'rails_helper'

RSpec.describe User, type: :feature do
  include Capybara::DSL

  before(:each) do
    allow_any_instance_of(FitbitService).to receive(:steps).and_return("123")
    allow_any_instance_of(FitbitService).to receive(:calories).and_return("123456")
    allow_any_instance_of(FitbitService).to receive(:floors).and_return("12")
    allow_any_instance_of(FitbitService).to receive(:age).and_return(29)
    allow_any_instance_of(FitbitService).to receive(:dob).and_return("1985-12-21")
    allow_any_instance_of(FitbitService).to receive(:gender).and_return("Female")
    allow_any_instance_of(FitbitService).to receive(:badges).and_return(["10,000 steps in a day", "another badge"])
    visit '/'
    stub_omniauth_user
    click_on 'Login with Fitbit'
    click_on 'Goals'
  end

  it 'can view weekly percentage to goal' do

  end
end
