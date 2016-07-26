require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is invalid without an email' do
    user = User.create(
        password: 'password',
        password_confirmation: 'password')
    expect(user).to_not be_valid
    expect(user.errors[:email]).to include("can't be blank")
  end
  
  it 'is invalid without a password when creating a new user' do
    user = User.create(email: 'jack.sparrow@test.com')
    expect(user).to_not be_valid
    expect(user.errors[:password]).to include("can't be blank")
  end

  it 'is invalid with a duplicate email address' do
    User.create(email: 'jack_sparrow@test.com', password: 'abcd1234')
    user = User.create(
        email: 'jack_sparrow@test.com',
        password: 'abcd1234')
    expect(user).to_not be_valid
    expect(user.errors[:email]).to include("has already been taken")
  end

  describe 'Update' do
    it "changes the password only and only if we provide a new password" do
      
      # change the email won't change the password
      user = User.create(email: 'jack_sparrow@test.com', password: 'abcd1234')
      user.reload
      user.email = "test@test.com"
      encrypted_password = user.encrypted_password
      user.save
      user.reload
      expect(user.email).to eq("test@test.com")
      expect(user.encrypted_password).to eq(encrypted_password)
      
      user.password = "new_password"
      user.save
      user.reload
      expect(user.encrypted_password).to_not eq(encrypted_password)
    end
  end
end
