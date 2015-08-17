require 'rails_helper'

RSpec.describe User, type: :feature do

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
    click_on 'Profile'
  end

  it 'can view their profile' do
    expect(page).to have_content("sally")
    expect(page).to have_content(29)
    expect(page).to have_content('1985-12-21')
    expect(page).to have_content('Female')
    expect(page).to have_content("Top Badges")
  end

  it 'can create new awake times' do
    fill_in 'profile[awake_time]', with: '8:00'
    fill_in 'profile[sleep_time]', with: '19:00'
    click_on 'submit'
    expect(page).to have_content('8:00AM')
    expect(page).to have_content('7:00PM')
  end

  it 'can update awake times' do
    fill_in 'profile[awake_time]', with: '8:00'
    fill_in 'profile[sleep_time]', with: '19:00'
    click_on 'submit'
    expect(page).to have_content('8:00AM')
    expect(page).to have_content('7:00PM')
    fill_in 'profile[awake_time]', with: '9:00'
    fill_in 'profile[sleep_time]', with: '21:00'
    click_on 'submit'
    expect(page).not_to have_content('8:00AM')
    expect(page).not_to have_content('7:00PM')
    expect(page).to have_content('9:00AM')
    expect(page).to have_content('9:00PM')
  end
end
