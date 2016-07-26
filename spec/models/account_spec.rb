require 'rails_helper'

RSpec.describe Account, type: :model do
  let(:account) do
      user = User.create(username: 'mike', password: '1234abcd', password_confirmation: '1234abcd')
      user.create_account()
    end

  describe "deposit values" do
    it 'a new account must start with balance equal to 0' do
      expect(account.balance).to eq(0)
    end

    it 'can deposit a certain ammount (#deposit)' do
      account.deposit(100, 'salary')
      
      expect(account.balance).to eq(100)
    end

    it 'a new deposit increments the balance' do
      account.deposit(100, 'salary')
      account.deposit(300, 'salary')
      
      expect(account.balance).to eq(400)
    end

    it 'creates a credit transaction' do
      expect{ account.deposit(100, 'salary') }.to change{ account.transactions.count }.by(1)
      expect(account.transactions.last).to be_an_instance_of(Credit)
    end
  end

  describe "Withdraw" do
    it "Can't withdraw when balance is 0" do
      account.withdraw(100, 'salary')

      expect(account.balance).to eq(0)
    end

    it "Can't widthdraw with insuficient balance" do
      account.deposit(50, 'salary')

      account.withdraw(100, 'salary')

      expect(account.balance).to eq(50)
    end

    it "Decrements the balance" do
      account.deposit(100, 'salary')

      account.withdraw(50, 'salary')

      expect(account.balance).to eq(50)
    end

    it 'creates a debit transaction' do
      account.deposit(200, 'salary')
      expect{ account.withdraw(100, 'iPad') }.to change{ account.transactions.count }.by(1)
      expect(account.transactions.last).to be_an_instance_of(Debit)
    end
  end

  describe 'Change balance' do
    it 'persits balance with a deposit' do
      account.deposit(100, 'salary')

      expect(account.reload.balance).to eq(100)
    end

    it 'persits balance with a withdraw' do
      account.deposit(100, 'salary')
      account.withdraw(50, 'salary')

      expect(account.reload.balance).to eq(50)
    end
  end
end
