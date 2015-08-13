require 'rails_helper'

RSpec.describe Goal, type: :model do
  let(:user) { User.create(username: "sally", uid: '123456', token: '1111', secret:"12345", provider:"fitbot") }

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

  # it 'can find by uid' do
  #   u = User.find_or_create_from_oauth(user)
  #
  #   expect(u.uid).to eq(user.uid)
  #   expect(u.token).to eq(user.token)
  # end
end
