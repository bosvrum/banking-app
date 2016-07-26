require 'rails_helper'

RSpec.describe User, type: :model do
  let(:account) do
      user = User.create(username: 'mike', password: '1234abcd', password_confirmation: '1234abcd')
      user.create_account()
    end

  describe "deposit values" do
    it 'a new account must start with balance equal to 0' do
      expect(account.balance).to eq(0)
    end

    it 'can deposit a certain ammount (#deposit)' do
      account.deposit(100)
      
      expect(account.balance).to eq(100)
    end

    it 'a new deposit increments the balance' do
      account.deposit(100)
      account.deposit(300)
      
      expect(account.balance).to eq(400)
    end
  end

  describe "Withdraw" do
    it "Can't withdraw when balance is 0" do
      account.withdraw(100)

      expect(account.balance).to eq(0)
    end

    it "Can't widthdraw with insuficient balance" do
      account.deposit(50)

      account.withdraw(100)

      expect(account.balance).to eq(50)
    end

    it "Decrements the balance" do
      account.deposit(100)

      account.withdraw(50)

      expect(account.balance).to eq(50)
    end
  end

  describe 'Change balance' do
    it 'persits balance with a deposit' do
      account.deposit(100)

      expect(account.reload.balance).to eq(100)
    end

    it 'persits balance with a withdraw' do
      account.deposit(100)
      account.withdraw(50)

      expect(account.reload.balance).to eq(50)
    end
  end
end
