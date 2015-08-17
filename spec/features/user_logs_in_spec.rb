require 'rails_helper'

RSpec.describe 'user can log in', type: :feature do
  include Capybara::DSL

  before(:each) do
    allow_any_instance_of(FitbitService).to receive(:steps).and_return("123")
    allow_any_instance_of(FitbitService).to receive(:calories).and_return("123456")
    allow_any_instance_of(FitbitService).to receive(:floors).and_return("12")
    allow_any_instance_of(FitbitService).to receive(:age).and_return(29)
    allow_any_instance_of(FitbitService).to receive(:dob).and_return("1985-12-21")
    allow_any_instance_of(FitbitService).to receive(:gender).and_return("Female")
    allow_any_instance_of(FitbitService).to receive(:badges).and_return(["10,000 steps in a day", "another badge"])
  end

  it 'can login to fitbit' do
    visit '/'
    assert_equal 200, page.status_code
    expect(page).not_to have_content("Dashboard")
    stub_omniauth_user
    click_on 'Login with Fitbit'
    expect(page).to have_content("Steps")
    expect(page).to have_content("Dashboard")
    expect(page).to have_content("Calories")
    expect(page).to have_content("Floors")
    expect(page).to have_content("Profile")
    expect(page).to have_content("Goals")
    expect(page).to have_content("Notifications")
    expect(page).to have_content("Friends")
  end

  it 'can logout from fitbit' do
    visit '/'
    assert_equal 200, page.status_code
    expect(page).not_to have_content("Dashboard")
    stub_omniauth_user
    click_on 'Login with Fitbit'
    expect(page).to have_content("Steps")
    find('a#logout').click
    expect(page).to have_content('Login with Fitbit')
  end

end
