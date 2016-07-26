# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
u = User.create(username: 'mike', email: 'mike@test.com', password: 'abcd1234', password_confirmation: 'abcd1234')
u.create_account()

u.account.deposit(100, 'Operation 1 - 3 months ago')
u.account.deposit(100, 'Operation 1 - last month')
u.account.deposit(100, 'Operation 1 - last month')
u.account.deposit(100, 'Operation 2 - 3 days ago')
u.account.deposit(100, 'Operation 3 - 1 day ago')
u.account.deposit(100, 'Operation 5 - today')

u = User.create(username: 'mary', email: 'mary@test.com', password: 'abcd1234', password_confirmation: 'abcd1234')
u.create_account()
