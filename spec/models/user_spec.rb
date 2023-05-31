require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = User.create(name: 'Test user', email: 'test444@gmail.com', password: '123456',
                        password_confirmation: '123456', confirmation_token: nil, confirmed_at: Time.now)
  end
  it 'is valid with valid attributes' do
    expect(@user).to be_valid
  end
  it 'is not valid without a name' do
    @user.name = nil
    expect(@user).to_not be_valid
  end
  it 'is not valid without an email' do
    @user.email = nil
    expect(@user).to_not be_valid
  end
  it 'is not valid without a password' do
    @user.password = nil
    expect(@user).to_not be_valid
  end
  it 'is not valid with a password confirmation that does not match' do
    @user.password_confirmation = '12345'
    expect(@user).to_not be_valid
  end
  it 'is not valid with a password shorter than 6 characters' do
    @user.password = '12345'
    expect(@user).to_not be_valid
  end
end
