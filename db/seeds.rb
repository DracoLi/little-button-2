# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

company = Company.create({
  name: 'Draken Solutions',
  email_domain: 'dracoli.com',
  botname: 'Draco Bot',
  timezone: 'Eastern Time (US & Canada)'
})
user = User.new({
  company: company,
  admin: true,
  name: 'Draco Li',
  email: 'draco@dracoli.com',
  password: 'password'
})
user.skip_confirmation!
user.save!
user.no_welcome_email = true
user.confirm!
