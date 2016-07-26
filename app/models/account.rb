class Account < ActiveRecord::Base
  belongs_to :user

  def deposit(amount)
    self.balance += amount
    save!
  end

  def withdraw(ammount)
    self.balance -= ammount if self.balance >= ammount
    save!
  end
end
