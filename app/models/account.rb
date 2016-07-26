class Account < ActiveRecord::Base
  belongs_to :user

  has_many :transactions, class_name: 'AccountTransaction', foreign_key: 'account_id'

  def deposit(amount,description)
    self.balance += amount
    save!
    transactions << Credit.create(value: amount, description: description)
  end

  def withdraw(amount,description)
    if self.balance >= amount
      self.balance -= amount
      save!
      transactions << Debit.create(value: amount, description: description)
    end
  end

  def statement(start_date, end_date)
    transactions.where(created_at: start_date..end_date)
  end
  
  def monthly_statement(month, year)
    d = DateTime.new(year, month)
    statement(d.beginning_of_month, d.end_of_month)
  end
  
  def transfer(amount, description, target_email)
    target_user = User.find_by(email: target_email)
    
    if target_user
      if user.id != target_user.id # can't transfer to myself
        
        if withdraw(amount, description)
          target_user.account.deposit(amount, description)
        end
      end
    end
  end
end
