require 'rails_helper'

RSpec.describe Goal, type: :model do
  let(:user) { User.create(username: "sally", uid: '123456', token: '222', secret:"111", provider:"fitbot") }

  before(:each) do
    user
  end

  it 'is valid' do
    expect(user).to be_valid
  end

  it 'is invalid without a uid' do
    user.uid = nil
    expect(user).to_not be_valid
  end

  it 'can find by uid' do
    sally = User.find_or_create_from_oauth(stub_omniauth_user)
    expect(sally.uid).to eq(user.uid)
    expect(sally.token).to eq(user.token)
    expect(sally.secret).to eq(user.secret)
  end
end
