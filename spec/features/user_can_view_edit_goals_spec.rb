require 'rails_helper'

RSpec.describe User, type: :feature do
  let!(:user) { User.create(username: "sally",
    uid: '123456',
    token: '1111',
    secret:"12345",
    provider:"fitbit") }

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

  def set_awake_times
    click_on 'Profile'
    fill_in 'profile[awake_time]', with: '8:00'
    fill_in 'profile[sleep_time]', with: '19:00'
    click_on 'submit'
    click_on 'Goals'
  end

  def create_goals
    fill_in 'goal[steps]', with: '5000'
    click_on 'Create Goal'
  end

  it 'can view their profile' do
    expect(page).to have_content("Set some goals")
    expect(page).to have_content("Your goals")
    expect(page).not_to have_content("Update Goals")
    expect(page).to have_content("You currently have no goals set at this time. Step it up")
  end

  it 'cannot create a goal until awake times are set' do
    expect(page).to have_content("Must set awake times first over here")
  end

  it 'can create a goal' do
    set_awake_times
    create_goals
    expect(page).to have_content('5000')
    expect(page).to have_content('454')
    expect(page).not_to have_content("Set some goals here")
  end

  it 'can edit a goal' do
    set_awake_times
    create_goals
    fill_in 'goal[steps]', with:('15000')
    click_on 'Update Goal'
    expect(page).to have_content('15000')
    expect(page).to have_content('1363')
    expect(page).not_to have_content("Set some goals here")
  end

  it 'can delete a goal' do
    set_awake_times
    create_goals
    expect(page).to have_content('5000')
    expect(page).to have_content('454')
    click_on 'Delete'
    expect(page).not_to have_content('5000')
    expect(page).not_to have_content('454')
  end

  it 'can view weekly percentage on dashboard' do
    set_awake_times
    fill_in 'goal[steps]', with: '1000'
    click_on 'Create Goal'
    click_on 'Dashboard'
    expect(page).to have_content("You are 1% of the way to your goal..step it up")
    expect(page).to have_content("You are 12% of the way to your goal..step it up")
  end
end
