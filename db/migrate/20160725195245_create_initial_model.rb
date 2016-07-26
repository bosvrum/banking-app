class CreateInitialModel < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.references :user, index: true, foreign_key: true
      t.decimal :balance, default: '0'

      t.timestamps null: false
    end

    create_table :account_transactions do |t|
      t.decimal :value
      t.text :description
      t.string :type, index: true
      t.belongs_to :account, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
