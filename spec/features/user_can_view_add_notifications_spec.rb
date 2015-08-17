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
    click_on 'Profile'
    fill_in 'profile[awake_time]', with: '8:00'
    fill_in 'profile[sleep_time]', with: '19:00'
    click_on 'submit'
    click_on 'Goals'
    fill_in 'goal[steps]', with: '5000'
    click_on 'Create Goal'
    click_on 'Notifications'
  end

  before(:each) do
    allow_any_instance_of(FitbitService).to receive(:steps).and_return("123")
    allow_any_instance_of(FitbitService).to receive(:calories).and_return("123456")
    allow_any_instance_of(FitbitService).to receive(:floors).and_return("12")
    allow_any_instance_of(FitbitService).to receive(:age).and_return(29)
    allow_any_instance_of(FitbitService).to receive(:dob).and_return("1985-12-21")
    allow_any_instance_of(FitbitService).to receive(:gender).and_return("Female")
    allow_any_instance_of(FitbitService).to receive(:badges).and_return(["10,000 steps in a day", "another badge"])
  end

  it 'can add a text notification' do
    expect(page).to have_content("Text notifications will be sent every hour while you are awake to tell you how many steps you need to stay on track of your goal.")
    fill_in 'notification[number]', with: "7209364687"
    click_on 'Submit'
    expect(page).to have_content("You currently have text notifications set up. To delete click here")
  end

  it 'can delete a text notification' do
    fill_in 'notification[number]', with: "7209364687"
    click_on 'Submit'
    expect(page).to have_content("You currently have text notifications set up. To delete click here")
    expect(page).not_to have_content("Text notifications will be sent every hour while you are awake to tell you how many steps you need to stay on track of your goal.")
    click_on 'here'
    expect(page).to have_content("Text notifications will be sent every hour while you are awake to tell you how many steps you need to stay on track of your goal.")
    expect(page).not_to have_content("You currently have text notifications set up. To delete click here")
  end

  # it 'can send a text notifcation' do
  #   allow_any_instance_of(NotificationMessage).to receive(:notification(current_user)).and_return(@client.messages.create from: '7205063550', to: '7209364687', body: "asdf")
  #   NotificationMessage.new.steps_notification(user)
  # end
end
